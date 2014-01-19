
execute "Install yum epel repository" do
    command "rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm"
    not_if "rpm -qa | grep -q 'epel-release'"
end
