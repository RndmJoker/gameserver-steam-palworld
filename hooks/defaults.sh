#!/bin/bash
# ============================================================
# Palworld – Default Configuration Values
# Official docs: https://docs.palworldgame.com/settings-and-operation/configuration/
#
# Sets defaults for ALL Palworld parameters.
# Values are only applied if not already defined via .env or
# docker-compose environment variables.
# Sourced by pre-setup.sh BEFORE envsubst processes templates.
# ============================================================

# Enable auto-export so envsubst can see all variables
set -a

# ── Server Management ───────────────────────────────────────
: "${ServerName:=My Palworld Server}"
: "${ServerDescription:=}"
: "${ServerPassword:=}"
: "${AdminPassword:=}"
: "${ServerPlayerMaxNum:=32}"
: "${PublicIP:=}"
: "${RCONEnabled:=False}"
: "${RCONPort:=${RCON_PORT:-25575}}"
: "${RESTAPIEnabled:=False}"
: "${RESTAPIPort:=8212}"
: "${bUseAuth:=True}"
: "${BanListURL:=https://api.palworldgame.com/api/banlist.txt}"
: "${bIsUseBackupSaveData:=True}"
: "${bIsShowJoinLeftMessage:=True}"
: "${bAllowClientMod:=False}"
: "${ChatPostLimitPerMinute:=10}"
: "${LogFormatType:=Text}"
: "${Region:=}"

# ── Performance ─────────────────────────────────────────────
: "${BaseCampMaxNumInGuild:=4}"
: "${BaseCampWorkerMaxNum:=15}"
: "${MaxBuildingLimitNum:=0}"
: "${ServerReplicatePawnCullDistance:=15000.000000}"

# ── Game Mode ───────────────────────────────────────────────
: "${Difficulty:=None}"
: "${bIsMultiplay:=False}"
: "${bIsPvP:=False}"
: "${bHardcore:=False}"
: "${bCharacterRecreateInHardcore:=True}"

# ── Features ────────────────────────────────────────────────
: "${bEnablePlayerToPlayerDamage:=False}"
: "${bEnableFriendlyFire:=False}"
: "${bEnableInvaderEnemy:=True}"
: "${bActiveUNKO:=False}"
: "${bEnableAimAssistPad:=True}"
: "${bEnableAimAssistKeyboard:=False}"
: "${bEnableNonLoginPenalty:=True}"
: "${bEnableFastTravel:=True}"
: "${bEnableFastTravelOnlyBaseCamp:=False}"
: "${bIsStartLocationSelectByMap:=True}"
: "${bExistPlayerAfterLogout:=False}"
: "${bEnableDefenseOtherGuildPlayer:=False}"
: "${bBuildAreaLimit:=False}"
: "${bInvisibleOtherGuildBaseCampAreaFX:=False}"
: "${bShowPlayerList:=True}"
: "${bCanPickupOtherGuildDeathPenaltyDrop:=False}"
: "${bAutoResetGuildNoOnlinePlayers:=False}"
: "${AutoResetGuildTimeNoOnlinePlayers:=72.000000}"

# ── Randomizer ──────────────────────────────────────────────
: "${bIsRandomizerPalLevelRandom:=False}"
: "${RandomizerSeed:=0}"
: "${RandomizerType:=None}"

# ── Stat Enhancement ────────────────────────────────────────
: "${bAllowEnhanceStat_Attack:=True}"
: "${bAllowEnhanceStat_Health:=True}"
: "${bAllowEnhanceStat_Stamina:=True}"
: "${bAllowEnhanceStat_Weight:=True}"
: "${bAllowEnhanceStat_WorkSpeed:=True}"

# ── Global Palbox ───────────────────────────────────────────
: "${bAllowGlobalPalboxExport:=False}"
: "${bAllowGlobalPalboxImport:=False}"

# ── PvP ─────────────────────────────────────────────────────
: "${bAdditionalDropItemWhenPlayerKillingInPvPMode:=False}"
: "${AdditionalDropItemWhenPlayerKillingInPvPMode:=}"
: "${AdditionalDropItemNumWhenPlayerKillingInPvPMode:=0}"
: "${bDisplayPvPItemNumOnWorldMap_BaseCamp:=False}"
: "${bDisplayPvPItemNumOnWorldMap_Player:=False}"

# ── Items and Drops ─────────────────────────────────────────
: "${DropItemMaxNum:=3000}"
: "${DropItemMaxNum_UNKO:=100}"
: "${DropItemAliveMaxHours:=1.000000}"

# ── Limits ──────────────────────────────────────────────────
: "${BaseCampMaxNum:=128}"
: "${CoopPlayerMaxNum:=4}"
: "${GuildPlayerMaxNum:=20}"
: "${GuildRejoinCooldownMinutes:=0}"

# ── Game Balance – Rates ────────────────────────────────────
: "${DayTimeSpeedRate:=1.000000}"
: "${NightTimeSpeedRate:=1.000000}"
: "${ExpRate:=1.000000}"
: "${PalCaptureRate:=1.000000}"
: "${PalSpawnNumRate:=1.000000}"
: "${PalDamageRateAttack:=1.000000}"
: "${PalDamageRateDefense:=1.000000}"
: "${PlayerDamageRateAttack:=1.000000}"
: "${PlayerDamageRateDefense:=1.000000}"
: "${PlayerStomachDecreaceRate:=1.000000}"
: "${PlayerStaminaDecreaceRate:=1.000000}"
: "${PlayerAutoHPRegeneRate:=1.000000}"
: "${PlayerAutoHpRegeneRateInSleep:=1.000000}"
: "${PalStomachDecreaceRate:=1.000000}"
: "${PalStaminaDecreaceRate:=1.000000}"
: "${PalAutoHPRegeneRate:=1.000000}"
: "${PalAutoHpRegeneRateInSleep:=1.000000}"
: "${BuildObjectDamageRate:=1.000000}"
: "${BuildObjectDeteriorationDamageRate:=1.000000}"
: "${CollectionDropRate:=1.000000}"
: "${CollectionObjectHpRate:=1.000000}"
: "${CollectionObjectRespawnSpeedRate:=1.000000}"
: "${EnemyDropItemRate:=1.000000}"
: "${WorkSpeedRate:=1.000000}"
: "${ItemWeightRate:=1.000000}"
: "${ItemCorruptionMultiplier:=1.000000}"
: "${EquipmentDurabilityDamageRate:=1.000000}"

# ── Game Balance – Other ────────────────────────────────────
: "${DeathPenalty:=All}"
: "${bPalLost:=False}"
: "${PalEggDefaultHatchingTime:=72.000000}"
: "${BlockRespawnTime:=0.000000}"
: "${RespawnPenaltyDurationThreshold:=0.000000}"
: "${RespawnPenaltyTimeScale:=1.000000}"
: "${SupplyDropSpan:=180}"

# Disable auto-export
set +a
