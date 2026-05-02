# Palworld Dedicated Server (Docker)

A fully dockerized Palworld dedicated server that automatically downloads,
installs, updates, and configures itself on every start. Just run it.

- Platform: **Linux** (native dedicated server)
- Steam App ID: `2394010`
- Game Version: automatically updated via SteamCMD

---

## Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| CPU | 4 cores | 8+ cores |
| RAM | 8 GB | 16 GB |
| Disk | 10 GB free | 20 GB free |
| OS | Any Linux with Docker | Debian / Ubuntu |
| Docker | Docker Engine 24+ | latest stable |
| Docker Compose | v2 (included with Docker) | latest stable |

---

## Quick Start (Step by Step)

### 1. Install Docker (if not already installed)

```bash
curl -fsSL https://get.docker.com | sh
```

### 2. Clone this repository

```bash
git clone <REPO_URL> steam-palworld
cd steam-palworld
```

### 3. Create your configuration

```bash
cp .env.example .env
```

Open the `.env` file and change at least these settings:

```bash
nano .env
```

**Important settings to change:**
- `ServerName` -- The name players see in the server browser
- `AdminPassword` -- Password for admin commands (change from default!)
- `ServerPassword` -- Leave empty for a public server, set a password for private
- `ServerPlayerMaxNum` -- Maximum number of players (default: 32)

Everything else works out of the box with official default values.

### 4. Build and start the server

```bash
docker compose up -d --build
```

This will:
1. Build the Docker image (first time only, takes ~1 minute)
2. Download the Palworld server via SteamCMD (~3.8 GB, first time only)
3. Generate the configuration from your `.env` settings
4. Start the server

### 5. Watch the progress

```bash
docker compose logs -f
```

Wait until you see:

```
Running Palworld dedicated server on :8211
```

That means the server is ready for connections. Press `Ctrl+C` to stop watching logs (the server keeps running).

---

## Connecting to the Server

Players connect via the in-game server browser or by direct connect:

```
<YOUR_SERVER_IP>:8211
```

---

## Network

The server runs in **host network mode** (`network_mode: host`), which means
Docker uses the host machine's network directly. This is the recommended setup
for game servers because:

- No port mapping issues or NAT problems
- Better network performance and lower latency
- SteamCMD connects reliably without WebSocket timeout issues

**Ports used by the server:**

| Port | Protocol | Description |
|------|----------|-------------|
| `8211` | UDP | Game port (player connections) |
| `25575` | TCP | RCON port (remote console, disabled by default) |

If you have a firewall **outside** of Docker (e.g. on your hosting provider),
make sure port `8211/udp` is open. Docker's host mode does NOT automatically
open firewall ports on external firewalls.

---

## Configuration

All server settings are controlled through environment variables.
There are two ways to set them:

### Option A: Via `.env` file (recommended for docker compose)

Edit the [.env](.env.example) file:

```bash
nano .env
docker compose restart
```

### Option B: Directly in docker-compose.yml (recommended for Portainer)

All settings are listed in the `environment:` section of the
[docker-compose.yml](docker-compose.yml). Uncomment and change what you need.

### How defaults work

You do **not** need to set every value. The server has built-in defaults for
ALL settings (see [hooks/defaults.sh](hooks/defaults.sh)). If a setting is not
defined in your `.env` or `docker-compose.yml`, the official Palworld default
value is used automatically.

For a full description of what each setting does, see the
[official Palworld configuration docs](https://docs.palworldgame.com/settings-and-operation/configuration/).

---

## Deployment Examples

### docker-compose (recommended)

The [docker-compose.yml](docker-compose.yml) in this repo is a complete,
self-contained stack. It can be pasted directly into Portainer or Dockhand.

Minimal example showing only the most common settings:

```yaml
services:
  palworld:
    build: .
    container_name: palworld-server
    restart: unless-stopped
    network_mode: host
    mem_limit: 12g
    volumes:
      - serverdata:/home/steam/serverdata
      - serverconfig:/home/steam/serverconfig
    environment:
      - ServerName=My Palworld Server
      - AdminPassword=changeme
      - ServerPlayerMaxNum=32
      - RCONEnabled=False
      # All other settings use official defaults.
      # See the full docker-compose.yml for ALL available settings.

volumes:
  serverdata:
  serverconfig:
```

### docker run

```bash
# 1. Build the image
docker build -t palworld-server .

# 2. Start the server
docker run -d \
  --name palworld-server \
  --restart unless-stopped \
  --network host \
  --env-file .env \
  --memory 12g \
  -v serverdata:/home/steam/serverdata \
  -v serverconfig:/home/steam/serverconfig \
  palworld-server
```

---

## Server Management

### View live logs

```bash
docker compose logs -f
```

### Restart (applies config changes)

```bash
docker compose restart
```

### Stop the server

```bash
docker compose down
```

### Force update the game

The game is automatically updated on every container start. To manually
trigger an update:

```bash
docker compose restart
```

### Skip the update (faster restart)

If you want to restart without checking for game updates:

```bash
docker compose down
docker compose up -d -e SKIP_STEAM_UPDATE=true
```

### Rebuild the image after framework updates

```bash
docker compose up -d --build
```

---

## Volumes

The server data is stored in Docker volumes and persists across container
restarts and rebuilds.

| Volume | Container Path | Contents |
|--------|---------------|----------|
| `serverdata` | `/home/steam/serverdata` | Game files, save games, SteamCMD data |
| `serverconfig` | `/home/steam/serverconfig` | Config templates and generated configs |

To back up your save games:

```bash
docker cp palworld-server:/home/steam/serverdata/Pal/Saved ./backup
```

---

## Troubleshooting

### Server crashes immediately after starting

Check if you have enough RAM:

```bash
free -h
docker stats palworld-server --no-stream
```

Palworld requires at least 8 GB RAM. With 16 GB or more the server runs
stable.

### SteamCMD shows "Retrying..." for a long time

Make sure `network_mode: host` is set in your `docker-compose.yml`.
Docker's default bridge networking can break SteamCMD's WebSocket
connections.

### Players cannot connect

1. Check the server is running: `docker ps | grep palworld`
2. Check the game port is listening: `ss -tulnp | grep 8211`
3. Make sure port `8211/udp` is open in your hosting provider's firewall
4. If using a server password, make sure players enter the correct one

### View crash logs

```bash
docker logs palworld-server 2>&1 | tail -50
```

---

## Architecture

This server uses the [steam-server-base](https://github.com/rndmjoker/gameserver-steam-basic)
framework which provides:

- Automatic SteamCMD game updates on every container start
- Hook-based entrypoint for game-specific logic
- Config templating via `envsubst`
- Intelligent healthcheck (detects update vs. running phase)

### How the config system works

1. [hooks/defaults.sh](hooks/defaults.sh) sets official defaults for ALL parameters
2. Your `.env` file overrides only the settings you change
3. `envsubst` generates `PalWorldSettings.ini` from the template
4. The config is copied to the correct game directory automatically

---

## License

MIT
