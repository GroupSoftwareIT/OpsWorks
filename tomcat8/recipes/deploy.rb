app = search("aws_opsworks_app").first

Chef::Log.info("********** The app's short name is '#{app['shortname']}' **********")
Chef::Log.info("********** The app's URL is '#{app['app_source']['url']}' **********")

#remote_file "/opt/tomcat8/webapps/calendar.war" do
##  source node[:deploy]['appsource']['url']
#  source #{app['app_source']['url']}
#  owner 'root'
#  mode '0644'
#  action :create
#end


