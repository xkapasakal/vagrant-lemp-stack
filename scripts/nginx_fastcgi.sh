# !/bin/bash

sudo -s
nginx=stable # use nginx=development for latest development version
sudo add-apt-repository ppa:nginx/$nginx -y
sudo apt-get update 
sudo apt-get install nginx -y