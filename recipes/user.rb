#
# Cookbook:: golang
# Recipe:: user
#
# Copyright:: 2018, The Authors, All Rights Reserved.

go_owner = node['go']['owner']
go_owner_home = "/home/#{go_owner}"
go_group = node['dev']

# group go_group do
#   action :create
# end

user go_owner do
  group 'root'
  home "/home/#{go_owner}"
  shell '/bin/bash'
  manage_home true
  non_unique false
  action :create
end
