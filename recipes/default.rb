#
# Cookbook:: home-install
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'homebrew'

directory '/tmp/test' do
  owner 'pwagner'
  group 'staff'
  mode '0755'
  action :create
  not_if { ::File.directory?("/tmp/test") }
end

homebrew_package 'ffmpeg' do
  homebrew_user 'pwagner'
  options '--with-tools --with-wavpack --with-webp --with-x265
           --with-zeromq --with-openssl--with-openjpeg --with-openh264
           --with-libvorbis --with-libssh --with-libvidstab
           --with-libbluray --with-fdk-aac --with-freetype --with-libass'
  provider Chef::Provider::Package::Homebrew
  action :install
end

homebrew_package 'zsh' do
  homebrew_user 'pwagner'
  provider Chef::Provider::Package::Homebrew
  action :install
end

dmg_package 'VirtualBox' do
  owner 'pwagner'
  volumes_dir '/Volumes'
  source 'https://download.virtualbox.org/virtualbox/5.2.6/VirtualBox-5.2.6-120293-OSX.dmg'
end

homebrew_cask "google-chrome"
homebrew_cask "1password"
homebrew_cask "alfred"

# Atom stuff
homebrew_cask "atom"

node['atom']['packages'].each do |pkg|
  execute "Install #{pkg}" do
    command "/Applications/Atom.app/Contents/Resources/app/apm/bin/apm install #{pkg}"
    not_if { ::File.directory?("#{ENV['HOME']}/.atom/packages/#{pkg}") }
  end
end

cookbook_file "#{ENV['HOME']}/.atom/keymap.cson" do
  source 'keymap.cson'
  mode '0644'
  owner 'pwagner'
  group 'admin'
end


# mplayer avec libdvdread et l'autre truc
