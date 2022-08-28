# project name & prog lang
project('com.vixalien.Fonty', 'vala', 'c')

# include translations module
i18n = import('i18n')

# set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@@@"'.format(meson.project_name()), language: 'c')

# executable, files and dependencies
files = [
  'src' / 'Application.vala',
  'src' / 'Main.vala',
  'src' / 'Window.vala',
]

executable(
  meson.project_name(),
  files,
  dependencies: [
    dependency('gtk4'),
    dependency('pangocairo')
  ],
  install: true
)

# translate & install the .desktop file
i18n.merge_file(
  input: 'data' / 'fonty.desktop.in',
  output: meson.project_name() + '.desktop',
  po_dir: meson.source_root() / 'po',
  type: 'desktop',
  install: true,
  install_dir: get_option('datadir') / 'applications',
)

# translate & install the .metainfo.xml file
i18n.merge_file(
  input: 'data' / 'fonty.metainfo.xml.in',
  output: meson.project_name() + '.metainfo.xml',
  po_dir: meson.source_root() / 'po',
  install: true,
  install_dir: get_option('datadir') / 'metainfo',
)

subdir('po')

subdir('data' / 'icons')
