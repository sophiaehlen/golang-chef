#
# Cookbook:: golang
# Recipe:: go
#
# Author:: Sophia Ehlen (<ehlensophia@gmail.com)>
#
# Copyright:: 2018, Sophia Ehlen
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# load node attributes
go_version = node['go']['version']
go_install_dir = node['go']['install_path']
go_owner = node['go']['owner']
go_owner_home = node['etc']['passwd'][go_owner]['dir']


directory "#{go_owner_home}/go" do
	action :create
	not_if { File.exist?("/#{go_owner_home}/go")}
end

# download https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
remote_file 'go1.10.1.linux-amd64.tar.gz' do
	source 'https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz'
	not_if { File.exist?('/usr/local/go') }
end

execute 'extract-golang' do
	command 'tar -C /usr/local -xzf go1.10.1.linux-amd64.tar.gz'
	not_if { File.exist?('/usr/local/go') }
end


cookbook_file "#{go_owner_home}/.bash_profile" do
	source ".bash_profile"
	owner go_owner
end
