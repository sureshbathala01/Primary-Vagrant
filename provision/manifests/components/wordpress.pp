exec { "wp-cli-/usr/bin":
  command => "wget https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/bin/wp && chmod +x /usr/bin/wp",
  path    => ['/usr/bin' , '/bin'],
  creates => "/usr/bin/wp",
}

$plugins = [
  'log-deprecated-notices',
  'monster-widget',
  'query-monitor',
  'user-switching',
  'wordpress-importer',

  # WordPress.com
  'keyring',
  'mrss',
  'polldaddy',
  'rewrite-rules-inspector',
]

$github_plugins = {
  'vip-scanner'    => 'https://github.com/Automattic/vip-scanner',

  # WordPress.com
  'jetpack'        => 'https://github.com/Automattic/jetpack',
  'media-explorer' => 'https://github.com/Automattic/media-explorer',
  'writing-helper' => 'https://github.com/automattic/writing-helper',
  'amp'            => 'https://github.com/automattic/amp-wp',
}

# Delete broken plugins
file { '/var/www/vip.wordpress.pv/wp-content/plugins/log-viewer':
  ensure => 'absent',
  force  => true,
  before => Wp::Site['/var/www/vip.wordpress.pv/wp'],
}

# Install WordPress
wp::site { '/var/www/vip.wordpress.pv/wp':
  url             => 'vip.wordpress.pv',
  sitename        => 'vip.wordpress.pv',
  admin_user      => 'admin',
  admin_password  => 'password',
  network         => true,
  require         => [
    Vcsrepo['/var/www/vip.wordpress.pv/wp'],
    Class['php'],
  ]
}

# Install GitHub Plugins
$github_plugin_keys = keys( $github_plugins )
gitplugin { $github_plugin_keys:
  git_urls => $github_plugins
}

# Install plugins
wp::plugin { $plugins:
  location    => '/var/www/vip.wordpress.pv/wp',
  networkwide => true,
  require     => [
    Wp::Site['/var/www/vip.wordpress.pv/wp'],
    Gitplugin[ $github_plugin_keys ],
  ]
}

# Update all the plugins
wp::command { 'plugin update --all':
  command  => 'plugin update --all',
  location => '/var/www/vip.wordpress.pv/wp',
  require  => Wp::Site['/var/www/vip.wordpress.pv/wp'],
}

# Symlink db.php for Query Monitor
file { '/var/www/vip.wordpress.pv/wp-content/db.php':
  ensure  => 'link',
  target  => 'plugins/query-monitor/wp-content/db.php',
  require => Wp::Plugin['query-monitor']
}

wp::option { 'siteurl':
  ensure   => equal,
  value    => 'http://vip.wordpress.pv/wp',
  location => '/var/www/vip.wordpress.pv/wp',
  require  => Wp::Site['/var/www/vip.wordpress.pv/wp'],
}