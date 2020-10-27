#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2010-2019, Chef Software, Inc.
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
#

#Chef::Log.warn('The default tomcat recipe does nothing. See the readme for information on using the tomcat resources')

user  'chefuser'

group 'chef_group' do
  members 'chefuser'
  action :create
end

tomcat_install 'dirworld' do
  version '8.5.54'
  dir_mode '0755'
  tarball_uri 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.54/bin/apache-tomcat-8.5.54.tar.gz'
  tomcat_user 'chef_user'
  tomcat_group 'chef_group'
  create_symlink false
end

tomcat_service 'dirworld' do
  action  :start
  service_template_cookbook  'tomcat'
end

template '/opt/tomcat_dirworld_8_5_54/conf/server.xml' do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    shutdown_port: 8006,
    http_port: 8081,
    https_port: 8444
  )
  notifies :restart, 'tomcat_service[dirworld]'
end

remote_file '/opt/tomcat_dirworld_8_5_54/webapps/sample.war' do
  owner 'chef_user'
  mode '0644'
  source 'https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war'
  checksum '89b33caa5bf4cfd235f060c396cb1a5acb2734a1366db325676f48c5f5ed92e5'
end
