app = search("aws_opsworks_app").first

Chef::Log.info("********** The app's short name is '#{app['shortname']}' **********")
Chef::Log.info("********** The app's URL is '#{app['app_source']['url']}' **********")
Chef::Log.info("********** The app's deploy location is '#{app['attributes']['document_root']}' **********")

remote_file "/opt/tomcat8/webapps/#{app['shortname']}.war" do
  source '#{app['app_source']['url']}'
  owner 'root'
  mode '0644'
  action :create
end


