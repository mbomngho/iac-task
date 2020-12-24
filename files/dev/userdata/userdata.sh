#!/bin/bash -xe

#Docker
sudo yum update -y
sudo amazon-linux-extras install docker
sudo systemctl start --now --no-block docker.service
sudo usermod -a -G docker ec2-user

sudo mkdir -p ~/docker-nginx/html
wget https://raw.githubusercontent.com/nginxinc/NGINX-Demos/master/nginx-hello/index.html --output-document ~/docker-nginx/html/index.html
sudo docker run --name docker-nginx -p 80:80 -d -v ~/docker-nginx/html:/usr/share/nginx/html nginx:alpine
