# !/bin/bash

sudo apt-get install unzip build-essential zlib1g-dev libpcre3 libpcre3-dev -y

sudo adduser --system --no-create-home --disabled-login --disabled-password --group nginx

cd ~
wget -O release-1.7.30.3-beta.zip https://github.com/pagespeed/ngx_pagespeed/archive/release-1.7.30.3-beta.zip
unzip release-1.7.30.3-beta.zip
cd ngx_pagespeed-release-1.7.30.3-beta/
wget -O 1.7.30.3.tar.gz https://dl.google.com/dl/page-speed/psol/1.7.30.3.tar.gz
tar -xzvf 1.7.30.3.tar.gz # expands to psol/

cd ~
git clone https://github.com/FRiCKLE/ngx_cache_purge.git

cd ~
# check http://nginx.org/en/download.html for the latest version
wget http://nginx.org/download/nginx-1.4.4.tar.gz
tar -xvzf nginx-1.4.4.tar.gz
cd nginx-1.4.4/
./configure --user=nginx --group=nginx --add-module=$HOME/ngx_pagespeed-release-1.7.30.3-beta --add-module=$HOME/ngx_cache_purge
make
sudo make install

echo 'export PATH="/usr/local/nginx/sbin:$PATH"' >> ~/.bashrc
. ~/.bashrc

sudo cp /vagrant/scripts/conf/nginx.conf /usr/local/nginx/conf/

# sudo touch /usr/local/nginx/html/info.php
# echo '<?php phpinfo();?>' | sudo tee -a /usr/local/nginx/html/info.php

sudo cp /vagrant/scripts/etc/init/nginx.conf /etc/init/

# pagespeed configuration
# https://github.com/pagespeed/ngx_pagespeed/pull/547
sudo mkdir -p /var/ngx_pagespeed_cache
sudo chown -R nginx:nginx /var/ngx_pagespeed_cache
sudo mkdir -p /var/log/pagespeed
sudo chown -R nginx:nginx /var/log/pagespeed

# proxy cache
sudo mkdir -p /var/run/nginx-cache/
sudo chown -R nginx:nginx /var/run/nginx-cache/

sudo mkdir -p /var/www
sudo mkdir -p /etc/nginx/sites-available
sudo mkdir -p /etc/nginx/sites-enabled

sudo cp /vagrant/scripts/nginx/servers/proxy.server /etc/nginx/sites-available/
ip=$(ip addr | grep inet | grep global | awk -F" " '{print $2}'| sed -e 's/\/.*$//')
sudo sed -i "s/server_name localhost;/server_name $ip;/g" /etc/nginx/sites-available/proxy.server
sudo sed -i "s/proxy_redirect http:\/\/localhost:8050\/ http:\/\/localhost\/;/proxy_redirect http:\/\/localhost:8050\/ http:\/\/$ip\/;/g" /etc/nginx/sites-available/proxy.server
sudo sed -i "s/ip-address/$ip;/g" /etc/nginx/sites-available/proxy.server

sudo ln -s /etc/nginx/sites-available/proxy.server /etc/nginx/sites-enabled/proxy.server

sudo cp /vagrant/scripts/nginx/servers/wordpress.server /etc/nginx/sites-available/
# ip=$(ip addr | grep inet | grep global | awk -F" " '{print $2}'| sed -e 's/\/.*$//')
# sed -i 's/server_name localhost;/server_name $ip;/g' /etc/nginx/sites-available/wordpress.server
sudo ln -s /etc/nginx/sites-available/wordpress.server /etc/nginx/sites-enabled/wordpress.server

sudo service nginx start