#!/usr/bin/env bash

# Config
# Using '-e' ensures the script will exit if it encounters an error.
set -e
set -o pipefail

# Variables
VER=$1
BOT=$2
TWITCH_PATH="${HOME}/twitch"
DATE=`date +%m-%d-%Y`

# Sources
source "$HOME/common_tools/utils/color_codes.sh"
source "$HOME/common_tools/utils/logging_utils.sh"

traperr() {
	echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR

# SCRIPT START
c_hilight "Starting upgrade of $BOT"

c_info "Stopping $BOT"
pm2 stop $BOT
sleep 1

c_info "Downloading new build..."
cd $TWITCH_PATH
wget https://github.com/PhantomBot/PhantomBot/releases/download/v$VER/PhantomBot-$VER.zip
unzip PhantomBot-$VER.zip
rm PhantomBot-$VER.zip
sleep 1

c_info "Making adjustments to directories..."
mv "$TWITCH_PATH/$BOT" "$TWITCH_PATH/${BOT}-old"
mv PhantomBot-$VER $BOT
sleep 1

c_info "Copying old configs to new install..."
cp -R "./${BOT}-old/config/" $BOT
cp -R "./${BOT}-old/scripts/custom/" "./$BOT/scripts/"
cp -R "./${BOT}-old/scripts/lang/custom/" "./$BOT/scripts/lang/"
cp -R "./${BOT}-old/addons/followHandler" "./$BOT/addons/"
sleep 1

c_info "Backing up previous installation"
if [ -d "${TWITCH_PATH}/install_backups" ]; then
	c_success "Directory install_backups folder exists"
fi
if [[ ! -d "${TWITCH_PATH}/install_backups" ]]; then
	mkdir "${TWITCH_PATH}/install_backups"
	c_success "Created install_backups folder."
fi

mv "${BOT}-old" "${BOT}_${DATE}"
tar --exclude="${BOT}_${DATE}/dbbackup" --exclude="${BOT}_${DATE}/lib" --exclude="${BOT}_${DATE}/web" -czf "${BOT}_${DATE}.tar.gz" "${BOT}_${DATE}"
mv "${BOT}_${DATE}.tar.gz" "install_backups"
rm -rf "${BOT}_${DATE}"

cd $BOT
sudo chmod u+x launch-service.sh launch.sh ./java-runtime-linux/bin/java
sleep 1

c_info "Starting $BOT"
pm2 start $BOT

c_hilight "Finished $BOT update"
echo " "