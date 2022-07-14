#!/usr/bin/env bash

source "../../utils/color_codes.sh"

set -e

echo ''

c_info() {
  printf "\n ⭐${BGrey} %s${NC}\n" "$@"
  sleep 1
}

c_question() {
  printf "\n ❔${BCyan} %s${NC}\n" "$@"
  sleep 1
}

c_success() {
  printf "\n ✔️ ${BGreen} %s${NC}\n" "$@"
  sleep 1
}

c_error() {
  printf "\n ❌ ${Red} %s${NC}\n" "$@"
  sleep 1
}

c_warning() {
  printf "\n ⚠️ ${BYellow} %s${NC}\n" "$@"
  sleep 1
}

c_install() {
  printf "\n 🚧 ${Grey} %s${NC}\n" "$@"
}

c_hilight() {
  printf "${LightPurple} %s${NC}" "$@"
}