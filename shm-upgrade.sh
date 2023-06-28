#!/bin/bash

echo "===== Install Shardeum ====="
#curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
#echo "y"
#echo "y"
#echo "App147258."
#echo -e"\n"
#echo -e"\n"
#echo -e"\n"
CONTAINER_ID=$(docker-safe ps -qf "ancestor=local-dashboard")
sudo docker stop ${CONTAINER_ID}
rm installer.sh
curl -O https://raw.githubusercontent.com/zycode08/shardeum-script/main/installer.sh
bash installer.sh

docker-safe() {
  if ! command -v docker &>/dev/null; then
    echo "docker is not installed on this machine"
    exit 1
  fi

  if ! docker $@; then
    echo "Trying again with sudo..."
    sudo docker $@
  fi
}

docker-safe exec shardeum-dashboard operator-cli gui start
