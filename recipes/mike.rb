#
# Cookbook Name:: lvac
# Recipe:: mike
#
# Copyright (C) 2013 Mike Griffin
# 
# All rights reserved - Do Not Redistribute
#

home_dir = "/home/#{node[:mike][:user]}"

include_recipe "git"
include_recipe "vim"
include_recipe "composer"

group node[:mike][:group]

user node[:mike][:user] do
  group node[:mike][:group]
  home "#{home_dir}"
  supports :manage_home=>true
  shell "/bin/bash"
end

directory "#{home_dir}/.ssh" do
  owner node[:mike][:user]
  group node[:mike][:group]
  mode "0700"
  action :create
end

# setup ssh keys
file "#{home_dir}/.ssh/id_rsa" do
  owner node[:mike][:user]
  group node[:mike][:group]
  mode "0600"
  content node[:mike][:private_key]
  action :create
end

file "#{home_dir}/.ssh/id_rsa.pub" do
  owner node[:mike][:user]
  group node[:mike][:group]
  mode "0600"
  content node[:mike]['public_key']
  action :create
end

file "#{home_dir}/.ssh/authorized_keys" do
  owner node[:mike][:user]
  group node[:mike][:group]
  mode "0600"
  content node[:mike]['public_key']
  action :create
end

file "#{home_dir}/.ssh/config" do
  owner node[:mike][:user]
  group node[:mike][:group]
  mode "0600"
  content "Host github.com\n\tStrictHostKeyChecking no\n"
  action :create
end

# sync dotfiles
git "#{home_dir}/.dotfiles" do
  repository "git@github.com:mgriffin/dotfiles.git"
  reference "master"
  enable_submodules true
  user node[:mike][:user]
  group node[:mike][:group]
  action :sync
end

# # setup dotfiles
# bash "setup_dotfiles" do
#   cwd "#{home_dir}/.dotfiles"
#   user node[:mike][:user]
#   group node[:mike][:group]
#   environment "HOME" => home_dir
#   code "./setup.sh"
# end
