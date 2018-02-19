#
# Cookbook:: home-install
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

directory '/tmp/test' do
  # owner 'pwagner'
  # group 'staff'
  # mode '0755'
  # action :create
end

# homebrew_package 'ffmpeg' do
#   homebrew_user 'pwagner'
#   options '--with-tools --with-wavpack --with-webp --with-x265
#            --with-zeromq --with-openssl--with-openjpeg --with-openh264
#            --with-libvorbis --with-libssh --with-libvidstab
#            --with-libbluray --with-fdk-aac --with-freetype --with-libass'
#   provider Chef::Provider::Package::Homebrew
#   action :install
# end
#
# homebrew_package 'zsh' do
#   homebrew_user 'pwagner'
#   provider Chef::Provider::Package::Homebrew
#   action :install
# end

# dmg_package 'VirtualBox' do
#   owner 'pwagner'
#   volumes_dir '/Volumes'
#   source 'https://download.virtualbox.org/virtualbox/5.2.6/VirtualBox-5.2.6-120293-OSX.dmg'
# end

# homebrew_cask "google-chrome"

# mplayer avec libdvdread et l'autre truc
