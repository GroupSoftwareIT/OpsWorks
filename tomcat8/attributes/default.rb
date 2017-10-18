#
# Cookbook Name:: tomcat_latest
# Attributes:: default
#
# Copyright 2016, Franklin American Mortgage Company
# Copyright 2013, Chendil Kumar Manoharan
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

default['tomcat8']['download_url'] = "http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23.tar.gz"
default['tomcat8']['install_location'] = '/opt/tomcat8'
default['tomcat8']['port'] = 8080
default['tomcat8']['ssl_port'] = 8443
default['tomcat8']['ajp_port'] = 8009
default['tomcat8']['java_options'] = "-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"
default['tomcat8']['catalina_options'] = "-Xms512M -Xmx1024M -server -XX:+UseParallelGC -XX:MaxMetaspaceSize=1024m -Duser.timezone=+00:00"
default['tomcat8']['tomcat_user'] = "tomcat"
default['tomcat8']['autostart'] = "true"
default['tomcat8']['javahome'] = "/opt/jdk1.8.0_131"
