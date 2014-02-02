cd ~
wget -O latest.tar.gz http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

mysql -u root -ppassword < /vagrant/scripts/wordpress/config_mysql.sql

sudo rm -f ~/wordpress/readme.html
cp ~/wordpress/wp-config-sample.php ~/wordpress/wp-config.php
sed -i "s/define('DB_NAME', '.*');/define('DB_NAME', 'wordpress');/g" ~/wordpress/wp-config.php
sed -i "s/define('DB_USER', '.*');/define('DB_USER', 'wordpressuser');/g" ~/wordpress/wp-config.php
sed -i "s/define('DB_PASSWORD', '.*');/define('DB_PASSWORD', 'password');/g" ~/wordpress/wp-config.php

# wordpress with hhvm
# sudo sed -i "s/define( 'OBJECT', 'OBJECT', true );/define('OBJECT', 'OBJECT');define('Object', 'OBJECT');define('object', 'OBJECT');/g" ~/wordpress/wp-includes/wp-db.php

sudo cp -r ~/wordpress/* /var/www
cd /var/www/
sudo chown www-data:www-data * -R 
sudo usermod -a -G www-data nginx
