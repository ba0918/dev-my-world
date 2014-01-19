
service "iptables" do
    action [:stop, :disable]
end


%w{wget vim zsh}.each do |name|
    package name do
        action :install
    end
end
