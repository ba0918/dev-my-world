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
      chef.run_list = ["develop"]
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  end
end
