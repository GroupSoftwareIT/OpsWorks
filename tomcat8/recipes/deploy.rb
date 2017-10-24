app = search("aws_opsworks_app": "shortname:calendar").first

remote_file "/opt/tomcat8/webapps/calendar.war" do
#  source node[:deploy]['appsource']['url']
  source #{app['app_source']['url']}
  owner 'root'
  mode '0644'
  action :create
end


