#!/bin/bash

check=$(docker exec -i shardeum-dashboard /usr/local/bin/operator-cli status | grep 'state: stopped')
if [ "$check" ]; then
  echo "stopped"
  echo $(date +"%Y-%m-%d %H:%M:%S") "stopped" >> $HOME/shm-check.log
  docker exec -i shardeum-dashboard /usr/local/bin/operator-cli start
fi
