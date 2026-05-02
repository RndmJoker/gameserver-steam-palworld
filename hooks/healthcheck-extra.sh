#!/bin/bash
# ============================================================
# Palworld – extra healthcheck hook
# Runs after the base healthcheck passes (process + port OK).
#
# Use this for game-specific health validation, e.g.:
#   - Query server status via RCON
#   - Check a specific log file for errors
#   - Validate player count or world state
#
# Exit 0 = healthy, Exit 1 = unhealthy
# ============================================================

# Example: Check if RCON port is responding
# if [ -n "${RCON_PORT:-}" ]; then
#     ss -tlnp | grep -q ":${RCON_PORT} " || exit 1
# fi

exit 0
