default['user']['name'] = 'pwagner'
default['user']['group'] = 'staff'
default['terminal']['cursor_speed'] = 2
default['dmg']['packages'] =
[
  {
    "name" => "VirtualBox",
    "source" => "https://download.virtualbox.org/virtualbox/5.2.6/VirtualBox-5.2.6-120293-OSX.dmg"
  }
]
default['homebrew']['casks'] =
[
  'atom',
  'google-chrome',
  'alfred',
  '1password',
  'iterm2',
  'istat-menus',
  'docker',
  'evernote',
  'caffeine',
  'firefox'
]

default['homebrew']['packages'] =
{
  'git' => {
    'options' => ''
  },
  'ffmpeg' => {
    'options' => '--with-tools --with-wavpack --with-webp --with-x265
                  --with-zeromq --with-openssl--with-openjpeg --with-openh264
                  --with-libvorbis --with-libssh --with-libvidstab
                  --with-libbluray --with-fdk-aac --with-freetype --with-libass'
  },
  'zsh' => {
    'options' => ''
  },
  'go' => {
    'options' => ''
  },
  'thefuck' => {
    'options' => ''
  }
}

default['atom']['packages'] =
[
  'autoclose-html',
  'busy-signal',
  'go-debug',
  'go-plus',
  'go-signature-statusbar',
  'hyperclick',
  'import',
  'intentions',
  'language-docker',
  'linter',
  'linter-docker',
  'linter-ui-default',
  'markdown-writer',
  'multi-cursor',
  'language-chef'
]
