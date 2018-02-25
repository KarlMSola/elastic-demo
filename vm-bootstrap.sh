#!/bin/bash
# Install and prepare for Elastic demo

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce
sudo usermod -aG docker centos
sudo systemctl enable docker

sudo yum install -y java-1.8.0-openjdk-headless epel-release
sudo yum install -y jq git python2-pip
sudo pip install csvtojson
sudo pip install docker-compose

sudo systemctl start docker

sudo su - centos -c "git clone -b x-pack https://github.com/deviantony/docker-elk.git"
# Kill running containers just in case this is a re-run
sudo su - centos -c "docker stop $(docker ps -a -q); docker rm $(docker ps -a -q)"
# Start containers in daemon mode. See log through "docker logs" command
sudo su - centos -c "cd docker-elk && docker-compose up -d"
