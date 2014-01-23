# !/bin/bash

sudo apt-get update
sudo apt-get install python-software-properties -y

bash /vagrant/scripts/mysql.sh
sh /vagrant/scripts/expect.sh
expect /vagrant/scripts/mysql_secure.exp
bash /vagrant/scripts/php.sh
bash /vagrant/scripts/nginx_pagespeed.sh
bash /vagrant/scripts/wordpress.sh


# # To start mysqld at boot time you have to copy
# # support-files/mysql.server to the right place for your system

# # PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
# # To do so, start the server, then issue the following commands:

# #   /opt/mysql/server-5.6/bin/mysqladmin -u root password 'new-password'
# #   /opt/mysql/server-5.6/bin/mysqladmin -u root -h precise32 password 'new-password'

# # Alternatively you can run:

# #   /opt/mysql/server-5.6/bin/mysql_secure_installation

# # which will also give you the option of removing the test
# # databases and anonymous user created by default.  This is
# # strongly recommended for production servers.

# # See the manual for more instructions.

# # You can start the MySQL daemon with:

# #   cd /opt/mysql/server-5.6 ; /opt/mysql/server-5.6/bin/mysqld_safe &

# # You can test the MySQL daemon with mysql-test-run.pl

# #   cd mysql-test ; perl mysql-test-run.pl

# # Please report any problems with the /opt/mysql/server-5.6/bin/mysqlbug script!

# # The latest information about MySQL is available on the web at

# #   http://www.mysql.com

# # Support MySQL by buying support/licenses at http://shop.mysql.com

# # New default config file was created as /opt/mysql/server-5.6/my.cnf and
# # will be used by default by the server when you start it.
# # You may edit this file to change server settings
