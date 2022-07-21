#!/usr/bin/env bash

# Config
# Using '-e' ensures the script will exit if it encounters an error.
set -e
set -o pipefail

# Variables
DOCKER_IMAGE="$1"

# Sources
source "$HOME/common_tools/utils/color_codes.sh"
source "$HOME/common_tools/utils/logging_utils.sh"

traperr() {
	echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR

# SCRIPT START
c_hilight "Portainer Updater"
sleep 1

# Update Stand-alone or Agent

if [ "$DOCKER_IMAGE" = "standalone" ]; then
	c_info "Updating Standalone"
  sleep 1

  c_info "Stopping Portainter..."
  docker stop portainer
  docker rm portainer
  sleep 1

  c_info "Downloading latest community edition docker image..."
  docker pull portainer/portainer-ce:latest
  sleep 1

  c_info "Starting Portainer..."
  docker run -d -p 8000:8000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
  sleep 1

  c_info "Portainer Stand-alone update compelted!"
  sleep 1
	exit
fi
if [ "$DOCKER_IMAGE" = "agent" ]; then
	echo "Updating Agent"
	sleep 1

  c_info "Stopping Portainer Agent..."
  docker stop portainer_agent
  docker rm portainer_agent
  sleep 1

  c_info "Downloading latest docker image..."
  docker pull portainer/agent:latest
  sleep 1

  c_info "Starting Portainer Agent"
  docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
  sleep

  c_info "Portainer Agent update completed!"
  sleep 1
	exit
fi

c_error "Please enter standalone or agent parameter."
sleep 1
exit
