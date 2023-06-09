#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install curl

echo "===== Install Docker ====="
#sudo apt install docker.io
#echo "y";
wget -O get-docker.sh https://get.docker.com
sudo bash get-docker.sh

echo "===== Install Docker Compose ====="
sudo curl -L "https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "===== Set Cronjob ====="
wget https://raw.githubusercontent.com/zycode08/shardeum-script/main/shm-check.sh
chmod +x shm-check.sh

crontab -l > restartcron
echo "*/10 * * * * /root/shm-check.sh" >> restartcron
crontab restartcron
rm restartcron

echo "===== Install Shardeum ====="
#curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
#echo "y"
#echo "y"
#echo "App147258."
#echo -e"\n"
#echo -e"\n"
#echo -e"\n"
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
