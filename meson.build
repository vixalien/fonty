# project name & prog lang
project('com.vixalien.gtk-hello', 'vala', 'c')

# executable, files and dependencies
executable(
  meson.project_name(),
  'src' / 'Application.vala',
  dependencies: [
    dependency('gtk+-3.0')
  ],
  install: true
)

# install the .desktop file
install_data(
  'data' / 'gtk-hello.desktop',
  install_dir: get_option('datadir') / 'applications',
  rename: meson.project_name() + '.desktop'
)

# install the .metainfo.xml file
install_data(
  'data' / 'gtk-hello.metainfo.xml',
  install_dir: get_option('datadir') / 'metainfo',
  rename: meson.project_name() + '.metainfo.xml'
)
