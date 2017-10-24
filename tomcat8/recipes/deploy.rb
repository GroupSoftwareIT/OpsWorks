#app = search("aws_opsworks_app").first

remote_file "node['tomcat8']['deploy_location']/calendar.war" do
#  source node[:deploy]['appsource']['url']
  source 'https://s3.amazonaws.com/gopswordksdeps/calendar.war'
  owner 'root'
  mode '0644'
  action :create
end


