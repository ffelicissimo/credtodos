#!/bin/bash
######################### FERNANDO FELICISSIMO ##################################
sudo apt-get update 
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo groupadd docker
sudo usermod -aG docker ubuntu
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl restart --no-block docker
sudo systemctl enable docker
sudo rm -Rf /get-docker.sh
# Limpa repositório local
sudo apt-get clean 
sudo rm -rf /var/lib/apt/lists/*
##############################################################################

################### Executando Container #####################################
/bin/sh -c '/usr/bin/docker run --privileged -d -it $GERU_PASS --restart always -p 80:80 --name credtodosapi --net=host ffelicissimo/credtodos:latest'
#############################################################################