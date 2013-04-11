#
# Cookbook Name:: lvac
# Recipe:: default
#
# Copyright (C) 2013 Mike Griffin
# 
# All rights reserved - Do Not Redistribute
#
user 'mike'

include_recipe "apt"
include_recipe "mysql::server"
include_recipe "database"
include_recipe "nginx"

mysql_database "lvac" do
  connection({
    :host => "localhost",
    :username => "root",
    :password => node["mysql"]["server_root_password"]
  })
  action :create
end

directory "/var/www/lvac/current" do
  action :create
  recursive true
end

template "#{node['nginx']['dir']}/sites-available/lvac" do
  source "lvac_nginx"
  notifies :restart, "service[nginx]"
end

nginx_site "lvac" do
  enable true
end
