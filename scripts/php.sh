# !/bin/bash

sudo add-apt-repository ppa:ondrej/php5 -y
sudo apt-get update
# sudo apt-get upgrade -y

sudo apt-get install php5-fpm  php5-mysql -y
sudo sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sudo sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php5-fpm.sock/g' /etc/php5/fpm/pool.d/www.conf
sudo sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' /etc/php5/fpm/php.ini
sudo service php5-fpm restart