#
# Cookbook:: home-install
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'homebrew'

#################
# Brew Packages #
#################
node['homebrew']['packages'].each do |pkg, val|
  homebrew_package pkg do
    homebrew_user node['user']['name']
    options val['options']
    provider Chef::Provider::Package::Homebrew
    action :install
  end
end

########
# DMGs #
########
node['dmg']['packages'].each do |pkg|
  dmg_package "#{pkg['name']}" do
    owner node['user']['name']
    volumes_dir '/Volumes'
    source pkg['source']
  end
end

node['homebrew']['casks'].each do |cask|
  homebrew_cask cask
end

###############
# iTerm Stuff #
###############


##############
# Atom stuff #
##############
node['atom']['packages'].each do |pkg|
  execute "Install #{pkg}" do
    command "/Applications/Atom.app/Contents/Resources/app/apm/bin/apm install #{pkg}"
    not_if { ::File.directory?("#{ENV['HOME']}/.atom/packages/#{pkg}") }
  end
end

cookbook_file "#{ENV['HOME']}/.atom/keymap.cson" do
  source 'keymap.cson'
  mode '0644'
  owner node['user']['name']
  group node['user']['group']
end

#########################
# Zsh + Oh-my-zsh Stuff #
#########################
execute "Change shell for #{node['user']['name']}" do
  command "sudo chsh /usr/local/bin/zsh #{node['user']['name']}"
  action :run
  not_if "dscl . -read /Users/#{node['user']['name']} UserShell | grep zsh"
end

execute 'Install oh-my-zsh' do
  command 'curl -L http://install.ohmyz.sh | sh'
  user node['user']['name']
  action :run
  not_if { ::File.directory?("#{ENV['HOME']}/.oh-my-zsh") }
end

directory "#{ENV['HOME']}/.oh-my-zsh/custom/themes" do
  owner node['user']['name']
  group node['user']['group']
  mode '0751'
  action :create
end

cookbook_file "#{ENV['HOME']}/.oh-my-zsh/custom/themes/mh-pl.zsh-theme" do
  source 'mh-pl.zsh-theme'
  mode '0644'
  owner node['user']['name']
  group node['user']['group']
end

template "#{ENV['HOME']}/.zshrc" do
  source 'zshrc.erb'
  owner node['user']['name']
  group node['user']['group']
  mode '0644'
end

execute 'Install zsh syntax highlighting' do
  command "cd #{ENV['HOME']}/.oh-my-zsh && /usr/local/bin/git clone git://github.com/zsh-users/zsh-syntax-highlighting.git && cd"
  user node['user']['name']
  action :run
  not_if { ::File.directory?("#{ENV['HOME']}/.oh-my-zsh/zsh-syntax-highlighting") }
end

##################
# Python 3 Stuff #
##################

# Vim Stuff

# SSH Stuff

# Gpg stuff

# OSx system stuff

# mplayer avec libdvdread et l'autre truc
