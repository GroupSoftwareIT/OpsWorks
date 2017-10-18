#
# Cookbook:: jdk
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


tmp_path = Chef::Config[:file_cache_path]

#Download jdk archive
remote_file "#{tmp_path}/jdk.tar.gz" do
  source node['jdk']['download_url']
  owner node['jdk']['jdk_user']
  mode '0644'
  action :create
end

#Download JDK archive from Oracle website
#bash 'Download jdk archive' do
#  user node['jdk']['jdk_user']
#  cwd node['jdk']['install_location']
#  code <<-EOH
#    wget --no-cookies \
#--no-check-certificate \
#--header "Cookie: oraclelicense=accept-securebackup-cookie" \
#"node['jdk']['download_url']" \
#-O #{tmp_path}/jdk.tar.gz
#  EOH
#  action :run
#end

#create tomcat install dir
directory node['jdk']['install_location'] do
  owner node['jdk']['jdk_user']
  mode '0755'
  action :create
end

#Extract the tomcat archive to the install location
bash 'Extract tomcat archive' do
  user node['jdk']['jdk_user']
  cwd node['jdk']['install_location']
  code <<-EOH
    tar -zxvf #{tmp_path}/jdk.tar.gz --strip 1
  EOH
  action :run
end