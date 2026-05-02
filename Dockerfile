# ============================================================
# Palworld Dedicated Server
# Built on steam-server-base (Wine 11.0 + SteamCMD)
# ============================================================

FROM steam-server-base:wine-11.0

# ── Game Configuration ──────────────────────────────────────
ENV STEAM_APP_ID=2394010 \
    STEAM_PLATFORM=linux \
    GAME_BINARY="PalServer.sh" \
    GAME_PORT=8211

# ── Game Arguments (override via docker-compose or .env) ────
ENV GAME_ARGS=""

# ── Install game-specific hooks ─────────────────────────────
COPY hooks/ /opt/game-hooks/
RUN chmod +x /opt/game-hooks/*.sh 2>/dev/null || true

# ── Config templates ────────────────────────────────────────
COPY config/ /home/steam/serverconfig/

# ── Expose ports ────────────────────────────────────────────
EXPOSE 8211/udp
