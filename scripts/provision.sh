#!/bin/bash
# sudo -s
# instal latest nginx with apt-get
# sudo apt-get update
# nginx=stable # use nginx=development for latest development version
# sudo apt-get install python-software-properties -y
# sudo add-apt-repository ppa:nginx/$nginx -y
# sudo apt-get update -y
# sudo apt-get install nginx -y

sudo apt-get update

# Nginx with google ngx_pagespeed module
sudo apt-get install unzip -y
sudo apt-get install build-essential zlib1g-dev libpcre3 libpcre3-dev -y
cd ~
wget https://github.com/pagespeed/ngx_pagespeed/archive/release-1.7.30.3-beta.zip
unzip release-1.7.30.3-beta.zip
cd ngx_pagespeed-release-1.7.30.3-beta/
wget https://dl.google.com/dl/page-speed/psol/1.7.30.3.tar.gz
tar -xzvf 1.7.30.3.tar.gz # expands to psol/
cd ~

# check http://nginx.org/en/download.html for the latest version
wget http://nginx.org/download/nginx-1.4.4.tar.gz
tar -xvzf nginx-1.4.4.tar.gz
cd nginx-1.4.4/
./configure --add-module=$HOME/ngx_pagespeed-release-1.7.30.3-beta
make
sudo make install


# HHVM
cd ~
echo deb http://dl.hhvm.com/ubuntu precise main | sudo tee /etc/apt/sources.list.d/hhvm.list
sudo apt-get update
sudo apt-get install hhvm-fastcgi -y