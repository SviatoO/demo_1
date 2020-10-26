#
# Cookbook:: tomcat_v8
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

#require 'serverspec'

describe service('tomcat7') do
  it { should be_running }
end

describe port('8081') do
  it { should be_listening }
end

describe process('java') do
  it { should be_running }
  its(:args) { should match /org.apache.catalina.startup.Bootstrap/ }
end
