bash "install rbenv" do
    code <<-EOC
        git clone https://github.com/sstephenson/rbenv.git #{node[:rbenv][:base_dir]}
        git clone https://github.com/sstephenson/ruby-build.git #{node[:rbenv][:base_dir]}/plugins/ruby-build
        echo 'export RBENV_ROOT="#{node[:rbenv][:base_dir]}"' >> /etc/profile.d/rbenv.sh
        echo 'export PATH="#{node[:rbenv][:base_dir]}/bin:$PATH"' >> /etc/profile.d/rbenv.sh
        echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
        export export RBENV_ROOT="#{node[:rbenv][:base_dir]}"
        export PATH="#{node[:rbenv][:base_dir]}/bin:$PATH"
        eval "$(rbenv init -)"
    EOC
    creates "/usr/local/rbenv"
end

node[:rbenv][:versions].each do |version|
    bash "install ruby #{version}" do
        code <<-EOC
            export RBENV_ROOT="#{node[:rbenv][:base_dir]}"
            export PATH="#{node[:rbenv][:base_dir]}/bin:$PATH"
            eval "$(rbenv init -)"
            #{node[:rbenv][:base_dir]}/bin/rbenv install #{version}
        EOC
        not_if  "#{node[:rbenv][:base_dir]}/bin/rbenv versions | grep #{version}"
    end
end

bash "set ruby global version #{node[:rbenv][:global_version]}" do
    code <<-EOC
        export RBENV_ROOT="#{node[:rbenv][:base_dir]}"
        export PATH="#{node[:rbenv][:base_dir]}/bin:$PATH"
        eval "$(rbenv init -)"
        #{node[:rbenv][:base_dir]}/bin/rbenv global #{node[:rbenv][:global_version]}
    EOC
    not_if  "#{node[:rbenv][:base_dir]}/bin/rbenv global | grep #{node[:rbenv][:global_version]}"
end
