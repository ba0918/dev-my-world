
bash "install nvm" do
    code <<-EOC
        git clone https://github.com/creationix/nvm.git /usr/local/nvm
        . /usr/local/nvm/nvm.sh
    EOC
    creates "/usr/local/nvm"
end


template "/etc/profile.d/nvm.sh" do
    mode 0644
end


node[:nodejs][:versions].each do |version|
    bash "install node.js " + version do
        code <<-EOC
            . /usr/local/nvm/nvm.sh
            nvm install #{version}
        EOC
        not_if "nvm ls | grep #{version}"
    end
end


bash "set node.js global version " + node[:nodejs][:current] do
    code <<-EOC
        . /usr/local/nvm/nvm.sh
        nvm alias default #{node[:nodejs][:current]}
    EOC
    not_if "nvm current | grep #{node[:nodejs][:current]}"
end


node[:nodejs][:packages].each do |pkg|
    execute "install npm package #{pkg[:name]}" do
        cwd     "/usr/local/nvm/v#{node[:nodejs][:current]}/bin"
        command "npm install -g #{pkg[:name]}"
        not_if  "which #{pkg[:command]}"
    end
end
