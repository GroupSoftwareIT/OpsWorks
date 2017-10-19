#
# Cookbook:: gdefault
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#Instalar ferramentas de apoio
package ['htop', 'iftop', 'iotop', 'iptables-persistent', 'unzip', 'mysql-client']


#Configurar o timezone
bash 'timezone' do
  user root
  code <<-EOH
    echo "America/Sao_Paulo" > /etc/timezone
    dpkg-reconfigure --frontend noninteractive tzdata
  EOH
end


#Criar pasta de configuração
directory '/comunidade21/config' do
  owner 'root'
  group 'tomcat'
  mode '0775'
  action :create
end


#Definir configurações do iptables
template "/opt/iptables.rules" do
  source 'iptables-save.erb'
  owner root
  mode '0644'
end
bash 'iptables restore' do
  user root
  code <<-EOH
    iptables-restore < /opt/iptables.rules
  EOH
end


#Criar pasta para logs das aplicações
directory '/var/log/comunidades21' do
  owner 'root'
  group 'tomcat'
  mode '0660'
  action :create
end


#Criar pastas de apoio da aplicação
directory '/opt/comunidade21' do
  owner 'root'
  group 'tomcat'
  mode '0770'
  action :create
end
directory '/opt/comunidades21' do
  owner 'root'
  group 'tomcat'
  mode '0770'
  action :create
end
