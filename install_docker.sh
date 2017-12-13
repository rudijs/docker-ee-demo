#!/bin/bash

# this script is only tested on ubuntu xenial

# install docker
sudo apt-get update

sudo apt-get dist-upgrade -yy

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL $DOCKER_EE_URL/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] $DOCKER_EE_URL/ubuntu \
   $(lsb_release -cs) \
   stable-17.06"

sudo apt-get update

sudo apt-get install -yy docker-ee

sudo systemctl enable docker

sudo systemctl start docker

sudo usermod -aG docker ubuntu

# reboot
sudo init 6
