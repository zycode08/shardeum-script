#!/bin/bash
sudo apt update && apt upgrade -y

sudo apt-get install curl

##### Install Docker
#sudo apt install docker.io
#echo "y";
wget -O get-docker.sh https://get.docker.com
sudo bash get-docker.sh

##### Install Docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#### Set Cronjob
curl -O https://raw.githubusercontent.com/zycode08/shardeum-script/main/shm-check.sh
chmod +x shm-check.sh

crontab -l > restartcron
echo "*/10 * * * * /home/${USER}/shm-check.sh" >> restartcron
crontab restartcron
rm restartcron

##### Install Shardeum
#curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
#echo "y"
#echo "y"
#echo "App147258."
#echo -e"\n"
#echo -e"\n"
#echo -e"\n"
curl -O https://raw.githubusercontent.com/zycode08/shardeum-script/main/installer.sh && chmod +x installer.sh && ./installer.sh

cd .shardeum
./shell.sh

operator-cli gui start





