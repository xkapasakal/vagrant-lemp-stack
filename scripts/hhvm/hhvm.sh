# We have to change the fastcgi_pass param
# fastcgi_pass   127.0.0.1:9000;

wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
echo deb http://dl.hhvm.com/ubuntu precise main | sudo tee /etc/apt/sources.list.d/hhvm.list
sudo apt-get update
sudo apt-get install hhvm-fastcgi -y

echo 'Eval {' | sudo tee -a /etc/hhvm/config.hdf
echo 'JitASize = 134217728' | sudo tee -a /etc/hhvm/config.hdf
echo 'JitAStubsSize = 134217728' | sudo tee -a /etc/hhvm/config.hdf
echo 'JitGlobalDataSize = 67108864' | sudo tee -a /etc/hhvm/config.hdf
echo '}' | sudo tee -a /etc/hhvm/config.hdf

/usr/bin/hhvm --mode daemon --user web --config /etc/hhvm/server.hdf -vServer.Type=fastcgi -vServer.Port=9000
