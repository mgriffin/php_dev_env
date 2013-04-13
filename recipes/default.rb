#
# Cookbook Name:: lvac
# Recipe:: default
#
# Copyright (C) 2013 Mike Griffin
# 
# All rights reserved - Do Not Redistribute
#
include_recipe "apt"
include_recipe "zsh"
include_recipe "mysql::server"
include_recipe "database::mysql"
include_recipe "nginx"
include_recipe "php-fpm"
include_recipe "git"
include_recipe "vim"

group node[:lvac][:group]

user node[:lvac][:user] do
  group node[:lvac][:group]
  system true
  shell "/bin/zsh"
end

mysql_database "lvac" do
  connection({
    :host => "localhost",
    :username => "root",
    :password => node["mysql"]["server_root_password"]
  })
  action :create
end

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

template "/var/www/lvac/current/index.html" do
  source "index.html.erb"
  mode "0644"
end

nginx_site "lvac" do
  enable true
end

package "php5-mysql" do
  action :install
  notifies :restart, "service[nginx]"
end
