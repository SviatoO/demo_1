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
include_recipe 'java_se::default'

user  'chefuser'

group 'chef_group' do
  members 'chefuser'
  action :create
end

tomcat_install 'serve_demo' do
  version '8.5.54'
  dir_mode '0755'
  tarball_uri 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.54/bin/apache-tomcat-8.5.54.tar.gz'
  tomcat_user 'chef_user'
  tomcat_group 'chef_group'
  create_symlink false 
end


bash 'run_tomcat' do
  cwd '/tmp'
  code <<-EOH
    sh /opt/tomcat_serve_demo_8_5_54/bin/startup.sh
  EOH
end

