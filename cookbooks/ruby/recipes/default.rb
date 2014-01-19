bash "install rbenv" do
    code <<-EOC
        git clone https://github.com/sstephenson/rbenv.git #{node[:rbenv][:base_dir]}
        echo 'RBENV_ROOT=#{node[:rbenv][:base_dir]}'
        echo 'export PATH="#{node[:rbenv][:base_dir]}/bin:$PATH"' >> /etc/profile.d/rbenv.sh
        echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
    EOC
    creates "/usr/local/rbenv"
end

bash "install ruby-build" do
    code <<-EOC
        git clone https://github.com/sstephenson/ruby-build.git #{node[:rbenv][:base_dir]}/plugins/ruby-build
    EOC
    creates "#{node[:rbenv][:base_dir]}/plugins/ruby-build"
end

node[:rbenv][:versions].each do |version|
    execute "install ruby" do
        command "#{node[:rbenv][:base_dir]}/bin/rbenv install #{version}"
        not_if  "#{node[:rbenv][:base_dir]}/bin/rbenv versions | grep #{version}"
    end
end

execute "set ruby global version" do
    command "#{node[:rbenv][:base_dir]}/bin/rbenv global #{node[:rbenv][:global_version]}"
    not_if  "#{node[:rbenv][:base_dir]}/bin/rbenv global | grep #{node[:rbenv][:global_version]}"
end
