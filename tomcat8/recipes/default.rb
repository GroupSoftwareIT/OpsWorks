#
# Cookbook Name:: tomcat8
# Recipe:: default
#
# Copyright 2016, Franklin American Mortgage Company
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#include_recipe 'java'

tmp_path = Chef::Config[:file_cache_path]

#Create tomcat user
user 'tomcat' do
  comment 'Tomcat user'
  home '/opt/'
  shell '/bin/nologin'
  password '$1$JJsvHslasdfjVEroftprNn4JHtDi'
  action :create
end


#Download tomcat archive
remote_file "#{tmp_path}/tomcat8.tar.gz" do
  source node['tomcat8']['download_url']
  owner node['tomcat8']['tomcat_user']
  mode '0644'
  action :create
end


#create tomcat install dir
directory node['tomcat8']['install_location'] do
  owner node['tomcat8']['tomcat_user']
  mode '0755'
  action :create
end


#Extract the tomcat archive to the install location
bash 'Extract tomcat archive' do
  user node['tomcat8']['tomcat_user']
  cwd node['tomcat8']['install_location']
  code <<-EOH
    tar -zxvf #{tmp_path}/tomcat8.tar.gz --strip 1
  EOH
  action :run
end


#Install server.xml from template
template "#{node['tomcat8']['install_location']}/conf/server.xml" do
  source 'server.xml.erb'
  owner node['tomcat8']['tomcat_user']
  mode '0644'
end


#Install tomcat-users.xml from template
template "#{node['tomcat8']['install_location']}/conf/tomcat-users.xml" do
  source 'tomcat-users.erb'
  owner node['tomcat8']['tomcat_user']
  mode '0644'
end


#Install context.xml from template
template "#{node['tomcat8']['install_location']}/webapps/manager/META-INF/context.xml" do
  source 'manager-context.erb'
  owner node['tomcat8']['tomcat_user']
  mode '0644'
end


#Install init script
template "/etc/systemd/system/tomcat.service" do
  source 'tomcat8.erb'
  owner 'root'
  mode '0755'
end


#Set tomcat permissions
bash 'Set tomcat permissions' do
  user 'root'
  cwd node['tomcat8']['install_location']
  code <<-EOH
    chown -R root:tomcat node['tomcat8']['install_location']
	chown -R tomcat:tomcat ./work
	chown -R tomcat:tomcat ./temp
	chown -R tomcat:tomcat ./logs
	chmod 750 -R node['tomcat8']['install_location']
	chmod 770 -R ./webapps
  EOH
  action :run
end


#Start and enable tomcat service if requested
bash 'Start tomcat' do
  user 'root'
  code <<-EOH
    service tomcat start
  EOH
  action :run
end
