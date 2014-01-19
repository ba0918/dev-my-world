
service "iptables" do
    action [:stop, :disable]
end


%w{wget vim zsh openssl-devel}.each do |name|
    package name do
        action :install
    end
end
