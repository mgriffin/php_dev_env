# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'berkshelf/vagrant'

Vagrant.configure("2") do |config|
  config.vm.box = "debian32"
  config.vm.box_url = "https://dl.dropbox.com/u/2289657/squeeze32-vanilla.box"
  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "apt"
    chef.add_recipe "nginx"
    chef.add_recipe "mysql"
    chef.add_recipe "php-fpm"
  end
end
