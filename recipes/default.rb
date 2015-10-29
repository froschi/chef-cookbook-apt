include_recipe 'apt'

package 'apt-transport-https'

file '/etc/apt/sources.list' do
  action :delete
end

cookbook_file 'ubuntu.list' do
  path '/etc/apt/sources.list.d/ubuntu.list'
  action :create
  source 'ubuntu.list'
end

apt_update 'update'
