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
