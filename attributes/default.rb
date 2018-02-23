default['user']['name'] = 'pwagner'
default['user']['group'] = 'staff'
default['homebrew']['casks'] = [
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
default['homebrew']['packages'] = {
                                    'ffmpeg' => {
                                      'options' => '--with-tools --with-wavpack --with-webp --with-x265
                                                    --with-zeromq --with-openssl--with-openjpeg --with-openh264
                                                    --with-libvorbis --with-libssh --with-libvidstab
                                                    --with-libbluray --with-fdk-aac --with-freetype --with-libass'
                                    },
                                    'zsh' => {
                                      'options' => ''
                                    }
                                  }
default['atom']['packages'] = [ 'autoclose-html',
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
