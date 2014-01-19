# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos65"
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.omnibus.chef_version = :latest

  config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 1024]
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("basis")
    chef.add_recipe("yum")
    chef.add_recipe("nodejs")
    #chef.add_recipe("phpenv")
    chef.json = {
      :nodejs => {
        :current  => "0.10.24",
        :versions => [
          "0.10.24"
        ]
      },

      :php_global_version    => "5.5.8",
      :php_configure_options => "",
      :php => [
        {
          :version => "5.5.8",
          :ini     => "5_5"
        },
        {
          :version => "5.4.24",
          :ini     => "5_4"
        },
        {
          :version => "5.3.28",
          :ini     => "5_3"
        },
        {
          :version => "5.2.17",
          :ini     => "5_2"
        }
      ]
    }
  end
end
