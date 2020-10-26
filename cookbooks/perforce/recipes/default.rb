#
# Cookbook:: perforce
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

bash "install_perforce" do
    cwd "~/home"
    user "root"
    code <<-EOH
        cd /etc/yum.repos.d
        touch perforce.repo
        echo "[perforce]" > /etc/yum.repos.d/perforce.repo
        echo "name=Perforce" >> /etc/yum.repos.d/perforce.repo
        echo "baseurl=http://package.perforce.com/yum/rhel/6/x86_64/" >> /etc/yum.repos.d/perforce.repo
        echo "enabled=1" >> /etc/yum.repos.d/perforce.repo
        echo "gpgcheck=1" >> /etc/yum.repos.d/perforce.repo
        rpm --import http://package.perforce.com/perforce.pubkey
        yum install perforce-server
        yum install perforce-cli
    EOH
end
