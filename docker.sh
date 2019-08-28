#!/bin/bash
######################### FERNANDO FELICISSIMO ##################################
sudo apt-get update && apt-get upgrade -y \
             && apt-get dist-upgrade -y
sudo groupadd docker
sudo usermod -aG docker ubuntu
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl restart --no-block docker
sudo systemctl enable docker
# Limpa repositório local
sudo apt-get clean 
sudo rm -rf /var/lib/apt/lists/*
##############################################################################

################### Executando Container #####################################
/bin/sh -c '/usr/bin/docker run --privileged -dit --env-file=dev.env --restart always -p 80:80 --name credtodosapi --net=host ffelicissimo/credtodos:latest'
#############################################################################