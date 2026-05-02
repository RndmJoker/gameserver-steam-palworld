#!/bin/bash
# ============================================================
# Palworld – pre-setup hook
# Loads default values for all game settings before envsubst
# processes the config templates.
# ============================================================

log "Loading Palworld default configuration..."
source /opt/game-hooks/defaults.sh
log "Defaults loaded. User overrides from .env applied."
