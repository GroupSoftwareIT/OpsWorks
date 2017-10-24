#app = search("aws_opsworks_app").first

remote_file "node['tomcat8']['deploy_location']/node[:deploy]['shortname'].war" do
  source node[:deploy]['app_source']['url']
  owner 'root'
  mode '0644'
  action :create
end
