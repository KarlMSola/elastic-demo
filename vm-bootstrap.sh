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

sudo systemctl start docker
