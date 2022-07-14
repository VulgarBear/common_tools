#!/usr/bin/env bash

# Config
# Using '-e' ensures the script will exit if it encounters an error.
set -e
set -o pipefail

# Variables
VER=$1
BOT=$2
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
c_hilight "Starting Install of $BOT"

c_info "Downling build..."
cd $TWITCH_PATH
wget https://github.com/PhantomBot/PhantomBot/releases/download/v$VER/PhantomBot-$VER.zip
unzip PhantomBot-$VER.zip
rm PhantomBot-$VER.zip
sleep 1

c_info "Making adjustments to directories..."
mv PhantomBot-$VER $BOT
sleep 1

c_info "Configuring scripts for first run..."
cd $BOT
sudo chmod u+x launch-service.sh launch.sh ./java-runtime-linux/bin/java
sleep 1

c_info "Perform first run after configuring botlogin.txt"
sleep 1

c_hilight "Installation Completed"
echo " "