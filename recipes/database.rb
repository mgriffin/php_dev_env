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

mysql_database_user "lvac" do
  connection({
    :host => "localhost",
    :username => "root",
    :password => node["mysql"]["server_root_password"]
  })
  password "Runn3r"
  database_name "lvac_test"
  host "localhost"
  privileges [:all]
  action :grant
end

mysql_database "lvac_test" do
  connection({
    :host => "localhost",
    :username => "lvac",
    :password => "Runn3r"
  })
  action :create
end
