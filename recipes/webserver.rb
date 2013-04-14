#
# Cookbook Name:: lvac
# Recipe:: webserver
#
# Copyright (C) 2013 Mike Griffin
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"
include_recipe "php-fpm"

nginx_site "default" do
  enable false
end

template "#{node['nginx']['dir']}/sites-available/lvac" do
  source "lvac_nginx"
  notifies :restart, "service[nginx]"
end

directory "/var/www/lvac/current" do
  action :create
  recursive true
end

nginx_site "lvac" do
  enable true
end

package "php5-mysql" do
  action :install
  notifies :restart, "service[nginx]"
end
