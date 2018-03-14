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
  command "cd #{ENV['HOME']}/.oh-my-zsh/custom/plugins && /usr/local/bin/git clone git://github.com/zsh-users/zsh-syntax-highlighting.git && cd"
  user node['user']['name']
  action :run
  not_if { ::File.directory?("#{ENV['HOME']}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting") }
end

#############
# Vim Stuff #
#############
execute 'Install Vim plugins and configs' do
  command '/usr/local/bin/git clone https://github.com/slamont/Personal-Vim-Configs.git .vim'
  creates "#{ENV['HOME']}/.vim/setup_vim.sh"
  user node['user']['name']
  cwd ENV['HOME']
  action :run
end

execute 'Setup Vim' do
  command './setup_vim.sh'
  creates "#{ENV['HOME']}/.vimrc"
  cwd "#{ENV['HOME']}/.vim"
  user node['user']['name']
  action :run
end

####################
# OSx system stuff #
####################

execute 'Speed up terminal cursor' do
  command "defaults write NSGlobalDomain KeyRepeat -int #{node['terminal']['cursor_speed']}"
  user node['user']['name']
  action :run
  not_if "defaults read NSGlobalDomain KeyRepeat | grep #{node['terminal']['cursor_speed']}"
end

#defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Avoid creating .DS_Store files on network volumes
#defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Show item info below desktop icons
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# Enable tap to click (Trackpad)
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
# defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

###############
# iTerm Stuff #
###############

directory "#{ENV['HOME']}/src/iterm2" do
  owner node['user']['name']
  group node['user']['group']
  mode '0751'
  action :create
end

cookbook_file "#{ENV['HOME']}/src/iterm2/com.googlecode.iterm2.plist" do
  source 'com.googlecode.iterm2.plist'
  owner node['user']['name']
  group node['user']['group']
  mode '0751'
  action :create
  not_if { ::File.exist?("#{ENV['HOME']}/src/iterm2/com.googlecode.iterm2.plist") }
end

execute 'Load config for iTerm2' do
  command "defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string '#{ENV['HOME']}/src/iterm2' && defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true"
  user node['user']['name']
  cwd "#{ENV['HOME']}/src/iterm2"
  action :run
  not_if "defaults read com.googlecode.iterm2.plist LoadPrefsFromCustomFolder | grep 1"
end

##################
# Python 3 Stuff #
##################

# Chef Stuff
execute 'Install knife-block' do
  command '/usr/local/bin/chef gem install knife-block'
  action :run
  not_if '/usr/local/bin/chef gem list | grep knife-block'
end

# SSH Stuff

# Gpg stuff


# mplayer avec libdvdread et l'autre truc
