%w{mysql-devel mhash mhash-devel re2c libmcrypt libmcrypt-devel libxml2-devel bison bison-devel openssl-devel curl-devel libjpeg-devel libpng-devel libmcrypt-devel readline-devel libtidy-devel libxslt-devel httpd-devel enchant-devel libXpm libXpm-devel freetype-devel t1lib t1lib-devel gmp-devel libc-client-devel libicu-devel oniguruma-devel net-snmp net-snmp-devel bzip2-devel}.each do |name|
    package name do
        action :install
    end
end

bash "install phpenv and phpbuild" do
    code <<-EOC
        export PHPENV_ROOT=#{node[:php][:base_dir]}
        curl https://raw.github.com/CHH/phpenv/master/bin/phpenv-install.sh | sh
        git clone https://github.com/CHH/php-build #{node[:php][:base_dir]}/plugins/php-build
        echo 'export PHPENV_ROOT="#{node[:php][:base_dir]}"' >> /etc/profile.d/rbenv.sh
        echo 'export PATH="#{node[:php][:base_dir]}/bin:$PATH"' >> /etc/profile.d/rbenv.sh
        echo 'eval \"$(phpenv init -)\"' >> /etc/profile.d/rbenv.sh
        source /etc/profile.d/rbenv.sh
    EOC
    creates "#{node[:php][:base_dir]}"
end

node[:php][:versions].each do |php|
    version = php["version"]
    dir     = "#{node[:php][:base_dir]}/versions/" + php["version"]
    bash "install php " + version do
        code <<-EOC
            source /etc/profile.d/rbenv.sh
            export PHP_BUILD_CONFIGURE_OPTS="#{node[:php][:configure_option]}"
            phpenv install #{version}
            echo \"date.timezone =Asia/Tokyo\" >> #{dir}/etc/php.ini
        EOC
        creates dir
    end
end

bash "set php global version #{node[:php][:global_version]}" do
    code <<-EOC
        source /etc/profile.d/rbenv.sh
        phpenv global #{node[:php][:global_version]}
    EOC
    not_if "phpenv glogal | grep #{node[:php][:global_version]}"
end
