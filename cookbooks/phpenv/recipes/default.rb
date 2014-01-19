%w{mysql-devel mhash mhash-devel re2c libmcrypt libmcrypt-devel libxml2-devel bison bison-devel openssl-devel curl-devel libjpeg-devel libpng-devel libmcrypt-devel readline-devel libtidy-devel libxslt-devel httpd-devel enchant-devel libXpm libXpm-devel freetype-devel t1lib t1lib-devel gmp-devel libc-client-devel libicu-devel oniguruma-devel net-snmp net-snmp-devel bzip2-devel}.each do |name|
  package name do
    action :install
  end
end

bash "install phpenv and phpbuild" do
    cwd "/home/vagrant"
    user "vagrant"
    group "vagrant"
    creates "/home/vagrant/.phpenv"
    code <<-EOH
        export PHPENV_ROOT=/home/vagrant/.phpenv
        curl https://raw.github.com/CHH/phpenv/master/bin/phpenv-install.sh | sh
        mkdir /home/vagrant/.phpenv/plugins
        cd /home/vagrant/.phpenv/plugins
        git clone git://github.com/CHH/php-build.git
        echo 'PATH=$HOME/.phpenv/bin:$PATH # Add phpenv to PATH for scripting' >> /home/vagrant/.bashrc
        echo 'eval \"$(phpenv init -)\"' >> /home/vagrant/.bashrc
        source /home/vagrant/.bashrc
        git clone https://github.com/garamon/phpenv-apache-version
    EOH
end

node[:php].each do |php|
    version = php["version"]
    dir     = "/home/vagrant/.phpenv/versions/" + php["version"]
    bash "install php " + version do
        user  "vagrant"
        group "vagrant"
        code <<-EOH
            export PATH="/home/vagrant/.phpenv/bin:$PATH"
            export PHP_BUILD_CONFIGURE_OPTS="#{node[:php_configure_options]}"
            phpenv install #{version}
            echo \"date.timezone =Asia/Tokyo\" >> #{dir}/etc/php.ini
        EOH
        creates dir
    end
end

execute "set phpenv global" do
    user "vagrant"
    command "/home/vagrant/.phpenv/bin/phpenv global " + node[:php_global_version]
end
