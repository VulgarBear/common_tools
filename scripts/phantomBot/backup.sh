#!/usr/bin/env bash

# Config
# Using '-e' ensures the script will exit if it encounters an error.
set -e
set -o pipefail

# Variables
BOT=$1
TWITCH_PATH="${HOME}/twitch"
BOT_PATH="${TWITCH_PATH}/${BOT}"
DATE=`date +%m-%d-%Y`

# Sources
source "../../utils/color_codes.sh"
source "../../utils/logging_utils.sh"

traperr() {
	echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR

# SCRIPT START
c_hilight "Beginning Phantom Bot Backup"
sleep 1

# Check and Create backups folder if missing
c_info "Checking for backups folder..."

if [ -d "${TWITCH_PATH}/auto_backups" ]; then
	c_success "auto_backups folder exists"
fi
if [[ ! -d "${TWITCH_PATH}/auto_backups" ]]; then
	mkdir "${TWITCH_PATH}/auto_backups"
	c_success "Created auto_backups folder."
fi

# Begin Backup Steps
c_info "Backing up $BOT..."
sleep 1

tar --exclude="${BOT_PATH}/lib" --exclude="${BOT_PATH}/web" -czf "${BOT_PATH}_$DATE.tar.gz" "${BOT_PATH}"

c_info "Created ${BOT_PATH}/${BOT}_$DATE.tar.gz"
sleep 1

# Clean Up
c_info "Cleaning up..."
sleep 1

mv "${TWITCH_PATH}/${BOT}_$DATE.tar.gz" "${TWITCH_PATH}/auto_backups"

c_hilight "Backup Completed"
sleep 1
