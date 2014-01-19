# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos65"
  config.vm.synced_folder "../public", "/share", :create => true, :owner => 'vagrant', :group => 'vagrant'
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.omnibus.chef_version = :latest

  config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 1024]
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("basis")
    chef.add_recipe("yum")
    chef.add_recipe("ruby")
    chef.add_recipe("nodejs")
    chef.add_recipe("phpenv")
    chef.json = {

    }
  end
end
