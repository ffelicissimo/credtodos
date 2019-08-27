#!/bin/bash
######################### FERNANDO FELICISSIMO ##################################
sudo apt-get update && apt-get upgrade -y \
             && apt-get dist-upgrade -y
sudo usermod -aG docker $USER
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl restart --no-block docker
sudo systemctl enable docker
##############################################################################

################### Executando Container #####################################
/bin/sh -c '/usr/bin/docker run --privileged -d -p 80:80 --name credtodosapi --net=host ffelicissimo/credtodos:latest'
#############################################################################
#sudo apt-get remove docker docker-engine docker.io containerd runc
#sudo apt-get update
#sudo apt-get upgrade -y
#sudo apt-get install -y \
#    apt-transport-https \
#    ca-certificates \
#    curl \
#    gnupg-agent \
#    software-properties-common
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo apt-key fingerprint 0EBFCD88
#sudo add-apt-repository \
#   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) \
#   stable"
#sudo apt-get update
#sudo apt-get install -y docker-ce docker-ce-cli containerd.io
#sudo usermod -aG docker ubuntu
#sudo systemctl restart systemd-journald
#sudo systemctl daemon-reload
#sudo systemctl restart --no-block docker