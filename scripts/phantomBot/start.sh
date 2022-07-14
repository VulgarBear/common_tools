#!/usr/bin/env bash

# Config
# Using '-e' ensures the script will exit if it encounters an error.
set -e
set -o pipefail

# Variables
BOT=$1
TWITCH_PATH="${HOME}/twitch"


# Sources
source "$HOME/common_tools/utils/color_codes.sh"
source "$HOME/common_tools/utils/logging_utils.sh"

traperr() {
	echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR

# SCRIPT START
c_hilight "Starting $BOT"

pm2 start $TWITCH_PATH/$BOT/launch.sh --name "$BOT"

c_highlight "Started $BOT with pm2"
echo " "