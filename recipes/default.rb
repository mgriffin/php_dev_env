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

mysql_database "lvac" do
  connection({
    :host => "localhost",
    :username => "root",
    :password => node["mysql"]["server_root_password"]
  })
  action :create
end
