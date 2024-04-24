#!/usr/bin/env bash

set -eou pipefail

REMOTE_USER="${REMOTE_USER:-root}"

rsync -tv ./docker-compose.yml $REMOTE_USER@$HOST:wireguard/
ssh $REMOTE_USER@$HOST <<-SCRIPT.sh
  echo Starting wireguard container
  docker compose -f ./wireguard/docker-compose.yml up -d

  echo Installing uncomplicated firewall...
  apt-get install ufw
  echo uncomplicated firewall installed!

  echo opening up port 51820...
  ufw allow 51820/udp
  echo All complete !
SCRIPT.sh
