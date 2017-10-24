remote_file "node['tomcat8']['deploy_location']/#{app['shortname']}.war" do
  source #{app['app_source']['url']}
  owner 'root'
  mode '0644'
  action :create
end
