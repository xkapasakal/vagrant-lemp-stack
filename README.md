vagrand-lemp-stack
==================

vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-proxyconf

We cannot use `vagrant plugin install vagrant-berkshelf` since
it doesn't use the latest berkshelf. Instead we install berkshelf
with bundle and use the gem to install cookbooks in specific location
`rm -rf vendor/cookbooks`
`mkdir -p vendor/cookbooks`
`bundle exec berks vendor vendor/cookbooks`

`curl --compressed "http://localhost"`