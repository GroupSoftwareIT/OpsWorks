#
# Cookbook:: ubuntu-hardening
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


bash 'apt update && upgrade' do
  user root
  code <<-EOH
    apt-get update && apt-get -y upgrade
  EOH
  action :run
end


#Instalar o fail2ban
apt_package 'fail2ban' do
  package_name fail2ban
  action :install
end
#template "/etc/fail2ban/jail.conf" do
#  source 'fail2banjail.erb'
#  owner root
#  mode '0644'
#end


#Instalar rkhunter
apt_package 'rkhunter' do
  package_name rkhunter
  action :install
end
bash 'rkhunter init' do
  user root
  code <<-EOH
    rkhunter --update
    rkhunter --propupd
  EOH
  action :run
end


#Secure shared memory
bash 'Secure shared memory' do
  user root
  code <<-EOH
    export linha=`grep "tmpfs" /etc/fstab`
	if [ -z "$linha" ]; then
	  echo "tmpfs     /run/shm     tmpfs     defaults,noexec,nosuid     0     0" >> /etc/fstab
	fi
  EOH
  action :run
end


#SSH Hardening
template "/etc/ssh/sshd_config" do
  source 'sshd_config.erb'
  owner root
  mode '0644'
end


#Limitar o comando su ao grupo administrativo
user 'guser' do
  comment 'Group Admin User'
  home '/home/guser'
  shell '/bin/bash'
end
group 'gadmin' do
  action :create
  members node['ubhard']['admin_members']
  append true
end
bash 'su restrict' do
  user root
  code <<-EOH
    dpkg-statoverride --update --add root gadmin 4750 /bin/su
  EOH
end


#Sysctl
template "/etc/sysctl.d/60-gsysctl.conf" do
  source 'sysctl.erb'
  owner root
  mode '0644'
end


#IP Spoofing
template "/etc/host.conf" do
  source 'host.erb'
  owner root
  mode '0644'
end


#Análise de logs
package ['logwatch', 'libdate-manip-perl']


#Auditoria do sistema
package ['tiger', 'lynis']
