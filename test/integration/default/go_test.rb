# # encoding: utf-8

# Inspec test for recipe golang::go

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/



go_owner = 'dev'
go_owner_home = '/home/dev'

describe package('git') do
	it { should be_installed }
end

describe directory('/usr/local/go') do
	it { should exist }
	it { should be_owned_by 'root'}
end

%w{bin pkg src}.each do |dir|
	describe directory("/usr/local/go/#{dir}") do
		it { should exist }
	end
end


describe file("#{go_owner_home}/.bash_profile") do
	it { should exist }
	it { should be_owned_by go_owner}
	its('content') { should match(/export\sPATH=\$PATH:\/usr\/local\/go\/bin/)}
	its('content') { should match(/export\sGOPATH="\$HOME\/go"/) }
	its('content') { should match(/export\sPATH=\$PATH:\$GOPATH\/bin/) }
end


%w{go go/bin go/pkg go/src}.each do |dir|
	describe directory("#{go_owner_home}/#{dir}") do
		it { should exist }
    it { should be_owned_by go_owner }
	end
end


describe command('go') do
	it { should exist }
end
