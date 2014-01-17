# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos65"
  config.vm.synced_folder "./public", "/share"

  config.berkshelf.berksfile_path = "./recipes/Berksfile"
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "./recipes"
      chef.run_list = [
          "develop"
      ]
  end
end
