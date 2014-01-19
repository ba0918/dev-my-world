bash "install nvm" do
    code <<-EOC
        git clone https://github.com/creationix/nvm.git #{node[:nodejs][:base_dir]}
        echo '. #{node[:nodejs][:base_dir]}/nvm.sh' >> /etc/profile.d/nvm.sh
        . #{node[:nodejs][:base_dir]}/nvm.sh
    EOC
    creates "#{node[:nodejs][:base_dir]}"
end

node[:nodejs][:versions].each do |version|
    bash "install node.js " + version do
        code <<-EOC
            . #{node[:nodejs][:base_dir]}/nvm.sh
            nvm install #{version}
        EOC
        not_if "nvm ls | grep #{version}"
    end
end

bash "set node.js global version " + node[:nodejs][:global_version] do
    code <<-EOC
        . #{node[:nodejs][:base_dir]}/nvm.sh
        nvm alias default #{node[:nodejs][:global_version]}
    EOC
    not_if "nvm current | grep #{node[:nodejs][:global_version]}"
end

node[:nodejs][:packages].each do |pkg|
    execute "install npm package #{pkg[:name]}" do
        command "#{node[:nodejs][:base_dir]}/v#{node[:nodejs][:global_version]}/bin/npm install -g #{pkg[:name]}"
        not_if  "which #{pkg[:command]}"
    end
end
