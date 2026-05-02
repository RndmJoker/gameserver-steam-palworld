# Palworld Dedicated Server

Dockerized Palworld dedicated server built on [steam-server-base](https://github.com/rndmjoker/gameserver-steam-basic).

## Quick Start

```bash
# 1. Clone this repo
git clone <REPO_URL> steam-palworld
cd steam-palworld

# 2. Copy and edit environment config
cp .env.example .env
nano .env

# 3. Build and start
docker compose up -d

# 4. View logs
docker compose logs -f
```

## Configuration

All settings are controlled via environment variables in `.env`.
See [.env.example](.env.example) for all available options.

Changes take effect on restart:
```bash
nano .env
docker compose restart
```

## Deployment Examples

### docker-compose.yml
```yaml
services:
  palworld:
    build: .
    container_name: palworld-server
    restart: unless-stopped
    env_file:
      - .env
    volumes:
      - serverdata:/home/steam/serverdata
      - serverconfig:/home/steam/serverconfig
    ports:
      - "${GAME_PORT:-8211}:8211/udp"
      - "${RCON_PORT:-25575}:25575/tcp"
    # Uncomment for games with NAT issues:
    # network_mode: host
    mem_limit: 12g

volumes:
  serverdata:
  serverconfig:
```

### docker run
```bash
# Build the image first
docker build -t palworld-server .

# Run the server
docker run -d \
  --name palworld-server \
  --restart unless-stopped \
  --env-file .env \
  -v serverdata:/home/steam/serverdata \
  -v serverconfig:/home/steam/serverconfig \
  -p 8211:8211/udp \
  -p 25575:25575/tcp \
  --memory 12g \
  palworld-server
```

## Ports

| Port | Protocol | Description |
|------|----------|-------------|
| `8211` | udp | Game port |
| `25575` | tcp | RCON port |

## Volumes

| Volume | Path | Description |
|--------|------|-------------|
| `serverdata` | `/home/steam/serverdata` | Game files (SteamCMD managed) |
| `serverconfig` | `/home/steam/serverconfig` | Config templates and generated configs |

## System Requirements

- Docker + Docker Compose
- Minimum RAM: 12g
- Platform: linux

## Architecture

This server uses the [steam-server-base](https://github.com/rndmjoker/gameserver-steam-basic) image which provides:
- Automatic SteamCMD updates on every container start
- Hook-based entrypoint for game-specific logic
- Intelligent healthcheck (detects update vs. running phase)
- Config templating via `envsubst`

## License

MIT
