app = search("aws_opsworks_app").first

Chef::Log.info("********** The app's short name is '#{app['shortname']}' **********")
Chef::Log.info("********** The app's URL is '#{app['app_source']['url']}' **********")
Chef::Log.info("********** The app's deploy location is '#{app['attributes']['document_root']}' **********")

file "/opt/tomcat8/webapps/#{app['shortname']}.war" do
  action :delete
end
