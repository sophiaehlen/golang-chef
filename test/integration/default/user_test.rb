# # encoding: utf-8

# Inspec test for recipe golang::user

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

dev_user = 'dev'

describe user(dev_user) do
  it { should exist }
  its('group') { should eq 'root' }
  its('home') { should eq '/home/dev' }
  its('shell') { should eq '/bin/bash' }
end
