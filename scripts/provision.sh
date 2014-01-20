#!/usr/bin/expect --
# !/bin/bash


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
hhvm --mode daemon -vServer.Type=fastcgi -vServer.Port=9000

# MySQL
cd ~
sudo apt-get install expect -y
# wget -O mysql-5.6.deb http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.15-debian6.0-i686.deb
wget -O mysql-5.6.deb http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.15-debian6.0-x86_64.deb
sudo dpkg -i mysql-5.6.deb

sudo apt-get install libaio1 -y

sudo /opt/mysql/server-5.6/scripts/mysql_install_db

spawn /opt/mysql/server-5.6/bin/mysql_secure_installation

expect "Enter current password for root (enter for none):"
send "\r"
	
expect "Set root password?"
send "y\r"

expect "New password:"
send "password\r"

expect "Re-enter new password:"
send "password\r"

expect "Remove anonymous users?"
send "y\r"

expect "Disallow root login remotely?"
send "y\r"

expect "Remove test database and access to it?"
send "y\r"

expect "Reload privilege tables now?"
send "y\r"

puts "Ended expect script."


# To start mysqld at boot time you have to copy
# support-files/mysql.server to the right place for your system

# PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
# To do so, start the server, then issue the following commands:

#   /opt/mysql/server-5.6/bin/mysqladmin -u root password 'new-password'
#   /opt/mysql/server-5.6/bin/mysqladmin -u root -h precise32 password 'new-password'

# Alternatively you can run:

#   /opt/mysql/server-5.6/bin/mysql_secure_installation

# which will also give you the option of removing the test
# databases and anonymous user created by default.  This is
# strongly recommended for production servers.

# See the manual for more instructions.

# You can start the MySQL daemon with:

#   cd /opt/mysql/server-5.6 ; /opt/mysql/server-5.6/bin/mysqld_safe &

# You can test the MySQL daemon with mysql-test-run.pl

#   cd mysql-test ; perl mysql-test-run.pl

# Please report any problems with the /opt/mysql/server-5.6/bin/mysqlbug script!

# The latest information about MySQL is available on the web at

#   http://www.mysql.com

# Support MySQL by buying support/licenses at http://shop.mysql.com

# New default config file was created as /opt/mysql/server-5.6/my.cnf and
# will be used by default by the server when you start it.
# You may edit this file to change server settings
