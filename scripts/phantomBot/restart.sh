#!/usr/bin/env bash

# Config
# Using '-e' ensures the script will exit if it encounters an error.
set -e
set -o pipefail

# Variables
BOT=$1


# Sources
source "$HOME/common_tools/utils/color_codes.sh"
source "$HOME/common_tools/utils/logging_utils.sh"

traperr() {
	echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR

# SCRIPT START
c_hilight "Restarting $BOT"

pm2 restart $BOT

c_hilight "Restarted $BOT with pm2"
echo " "