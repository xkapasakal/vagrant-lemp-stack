apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A

echo 'deb http://repo.percona.com/apt precise main' | sudo tee -a /etc/apt/sources.list
echo 'deb-src http://repo.percona.com/apt precise main' | sudo tee -a /etc/apt/sources.list

sudo apt-get update
sudo apt-get install percona-xtrabackup -y
# sudo apt-get install xtrabackup_55 -y