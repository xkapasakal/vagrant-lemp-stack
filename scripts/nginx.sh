# !/bin/bash

sudo apt-get install unzip git build-essential zlib1g-dev libpcre3 libpcre3-dev -y

sudo adduser --system --no-create-home --disabled-login --disabled-password --group nginx

cd ~
wget https://github.com/pagespeed/ngx_pagespeed/archive/release-1.7.30.3-beta.zip
unzip release-1.7.30.3-beta.zip
cd ngx_pagespeed-release-1.7.30.3-beta/
wget https://dl.google.com/dl/page-speed/psol/1.7.30.3.tar.gz
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
# sudo mkdir -p /var/ngx_pagespeed_cache
# sudo mkdir -p /var/log/pagespeed

sudo mkdir -p /var/www
sudo mkdir -p /etc/nginx/sites-available
sudo mkdir -p /etc/nginx/sites-enabled
sudo cp /vagrant/scripts/wordpress/wordpress /etc/nginx/sites-available/
ip=$(ip addr | grep inet | grep global | awk -F" " '{print $2}'| sed -e 's/\/.*$//')
sed -i 's/server_name localhost;/server_name $ip;/g' /etc/nginx/sites-available/wordpress
sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/wordpress

sudo service nginx start