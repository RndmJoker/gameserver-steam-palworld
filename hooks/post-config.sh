#!/bin/bash
# ============================================================
# Palworld – post-config hook
# Runs after envsubst has processed config templates.
#
# Use this to copy generated configs to game-specific paths.
# Templates are in:  /home/steam/serverconfig/
# Game files are in: /home/steam/serverdata/
# ============================================================

log "Copying Palworld config files..."

# Example: Copy processed config to the game directory
CONFIG_DIR="${STEAM_INSTALL_DIR}/Pal/Saved/Config/LinuxServer"
mkdir -p "$CONFIG_DIR"
cp /home/steam/serverconfig/PalWorldSettings.ini "${CONFIG_DIR}/PalWorldSettings.ini"

log "Palworld config applied."
