#!/usr/bin/env bash

# Config
# Using '-e' ensures the script will exit if it encounters an error.
set -e
set -o pipefail

# Variables
COM_DIR="${HOME}/common_tools"
TWITCH_PATH="${HOME}/twitch"
BACKUP_FOLDER="${TWITCH_PATH}/auto_backups"

# Sources
source "../../utils/color_codes.sh"
source "../../utils/logging_utils.sh"

traperr() {
	echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR

# SCRIPT START
c_hilight "Starting Phantom Bot backup cleanup..."
sleep 1

# Verify auto_backups folder exists
if [ -d "${TWITCH_PATH}/auto_backups" ]; then
	c_success "auto_backups folder exists"
fi
if [[ ! -d "${TWITCH_PATH}/auto_backups" ]]; then
	c_error "No auto_backups directory found."
	sleep 1
	exit
fi

# Clean up files
days=$(( ( $(date '+%s') - $(date -d '3 months ago' '+%s') ) / 86400 ))
find $BACKUP_FOLDER/*.tar.gz -mtime +$days -type f -delete

c_hilight "Cleanup completed..."