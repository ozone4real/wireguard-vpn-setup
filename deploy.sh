#!/usr/bin/env bash
USER="${USER:-root}"

rsync -tv ./docker-compose.yml $USER@$HOST:wireguard/
ssh root@$HOST <<-SCRIPT
  echo Starting wireguard container
  docker compose -f ./wireguard/docker-compose.yml up -d
SCRIPT
