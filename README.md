# Palworld Dedicated Server

Dockerized Palworld dedicated server built on [steam-server-base](https://github.com/rndmjoker/gameserver-steam-basic).

- Platform: **Linux** (native dedicated server)
- Steam App ID: `2394010`

## Quick Start

```bash
# 1. Clone this repo
git clone <REPO_URL> steam-palworld
cd steam-palworld

# 2. Copy and edit environment config
cp .env.example .env
nano .env

# 3. Build and start
docker compose up -d --build

# 4. View logs
docker compose logs -f
```

## Configuration

All server settings are controlled via environment variables in `.env`.
See [.env.example](.env.example) for the full list of available options with descriptions.

**Default values are built in.** If a setting is not defined in `.env`, the server
automatically falls back to the official Palworld default (see [hooks/defaults.sh](hooks/defaults.sh)).

For a complete description of all parameters, see the
[official Palworld configuration docs](https://docs.palworldgame.com/settings-and-operation/configuration/).

Changes take effect on restart:
```bash
nano .env
docker compose restart
```

## Deployment Examples

The [docker-compose.yml](docker-compose.yml) in this repo is a complete, self-contained stack.
All settings are defined inline and can be pasted directly into Portainer or Dockhand.

### docker-compose.yml (minimal)
```yaml
services:
  palworld:
    image: gitea.br-hosting.com/joker/gameserver-steam-palworld:latest
    container_name: palworld-server
    restart: unless-stopped
    volumes:
      - serverdata:/home/steam/serverdata
      - serverconfig:/home/steam/serverconfig
    ports:
      - "8211:8211/udp"
      - "25575:25575/tcp"
    mem_limit: 12g
    environment:
      - ServerName=My Palworld Server
      - AdminPassword=changeme
      - ServerPlayerMaxNum=32
      - RCONEnabled=False
      # See the full docker-compose.yml for ALL available settings

volumes:
  serverdata:
  serverconfig:
```

### docker run
```bash
docker run -d \
  --name palworld-server \
  --restart unless-stopped \
  --env-file .env \
  -v serverdata:/home/steam/serverdata \
  -v serverconfig:/home/steam/serverconfig \
  -p 8211:8211/udp \
  -p 25575:25575/tcp \
  --memory 12g \
  gitea.br-hosting.com/joker/gameserver-steam-palworld:latest
```

## Ports

| Port | Protocol | Description |
|------|----------|-------------|
| `8211` | udp | Game port |
| `25575` | tcp | RCON (remote console) |

## Volumes

| Volume | Path | Description |
|--------|------|-------------|
| `serverdata` | `/home/steam/serverdata` | Game files (SteamCMD managed) |
| `serverconfig` | `/home/steam/serverconfig` | Config templates and generated configs |

## System Requirements

- Docker + Docker Compose
- Minimum RAM: 12 GB (16 GB recommended for 20+ players)
- Disk: ~8 GB for initial download
- Platform: Linux (native)

## Architecture

This server uses the [steam-server-base](https://github.com/rndmjoker/gameserver-steam-basic) image which provides:
- Automatic SteamCMD updates on every container start
- Hook-based entrypoint for game-specific logic
- Intelligent healthcheck (detects update vs. running phase)
- Config templating via `envsubst`

### Config Flow

1. `hooks/defaults.sh` sets safe defaults for ALL Palworld parameters
2. `.env` overrides only the settings you customize
3. `envsubst` generates `PalWorldSettings.ini` from the template
4. `hooks/post-config.sh` copies it to the correct game directory

## License

MIT
