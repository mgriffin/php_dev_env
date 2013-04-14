#
# Cookbook Name:: lvac
# Recipe:: database
#
# Copyright (C) 2013 Mike Griffin
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "mysql::server"
include_recipe "database::mysql"

mysql_database "lvac" do
  connection({
    :host => "localhost",
    :username => "root",
    :password => node["mysql"]["server_root_password"]
  })
  action :create
end
