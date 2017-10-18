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

default['jdk']['download_url'] = "http://gopswordksdeps.s3-website-us-east-1.amazonaws.com/jdk-8u131-linux-x64.tar.gz"
default['jdk']['install_location'] = '/opt/jdk'
default['jdk']['jdk_user'] = "root"
default['jdk']['javahome'] = "/opt/jdk1.8.0_131"
