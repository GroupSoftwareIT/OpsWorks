#
# Cookbook:: gdefault
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

tmp_path = Chef::Config[:file_cache_path]

#Instalar ferramentas de apoio
package ['htop', 'iftop', 'iotop', 'iptables-persistent', 'unzip', 'mysql-client']
package ['automake', 'autotools-dev', 'g++', 'libcurl4-gnutls-dev', 'libfuse-dev', 'libssl-dev', 'libxml2-dev', 'make', 'pkg-config']


#Configurar o timezone
bash 'timezone' do
  user 'root'
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
  recursive true
  action :create
end


#Definir configurações do iptables
template "/opt/iptables.rules" do
  source 'iptables-save.erb'
  owner 'root'
  mode '0644'
end
bash 'iptables restore' do
  user 'root'
  code <<-EOH
    iptables-restore < /opt/iptables.rules
  EOH
end


#Criar pasta para logs das aplicações
directory '/var/log/comunidades21' do
  owner 'root'
  group 'tomcat'
  mode '0660'
  recursive true
  action :create
end


#Criar pastas de apoio da aplicação
directory '/opt/comunidade21' do
  owner 'root'
  group 'tomcat'
  mode '0770'
  recursive true
  action :create
end
directory '/opt/comunidades21' do
  owner 'root'
  group 'tomcat'
  mode '0770'
  recursive true
  action :create
end


#Instalação do s3fs
remote_file "#{tmp_path}/s3fs.tgz" do
  source 'https://s3.amazonaws.com/gopswordksdeps/s3fs-fuse.tgz'
  owner 'root'
  mode '0644'
  action :create
end
template "/root/.passwd-s3fs" do
  source 's3pass.erb'
  owner 'root'
  mode '0600'
end
bash 'Extract s3fs archive' do
  user 'root'
  cwd '/opt/'
  code <<-EOH
    tar -zxvf #{tmp_path}/s3fs.tgz --strip 1
	cd s3fs-fuse
	./configure
	make clean && make
	make install
	s3fs -o allow_other -o passwd_file=/root/.passwd-s3fs comunidade21.config /comunidade21/
  EOH
  action :run
end
