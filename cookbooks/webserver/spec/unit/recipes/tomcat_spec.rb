#
# Cookbook:: webserver
# Spec:: tomcat
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'serverspec'

set :backend, :exec

describe service('tomcat7') do
  it { should be_running }
end

describe port('8081') do
  it { should be_listening }
end
