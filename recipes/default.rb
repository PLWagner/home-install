#
# Cookbook:: home-install
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'homebrew'

node['homebrew']['packages'].each do |pkg, val|
  homebrew_package pkg do
    homebrew_user node['user']['name']
    options val['options']
    provider Chef::Provider::Package::Homebrew
    action :install
  end
end

dmg_package 'VirtualBox' do
  owner 'pwagner'
  volumes_dir '/Volumes'
  source 'https://download.virtualbox.org/virtualbox/5.2.6/VirtualBox-5.2.6-120293-OSX.dmg'
end

node['homebrew']['casks'].each do |cask|
  homebrew_cask cask
end

# iTerm Stuff
#TODO

# Atom stuff
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

# Zsh + Oh-my-zsh Stuff

# Vim Stuff

# SSH Stuff

# Gpg stuff

# OSx system stuff

# mplayer avec libdvdread et l'autre truc
