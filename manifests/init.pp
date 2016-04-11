group { 'puppet': ensure => present }

Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/', '/var/vagrant/bin/' ] }
File { owner => 0, group => 0, mode => 0644 }

class { 'apt': }

apt::ppa { 'ppa:ondrej/php5-5.6': }

package { 'git':
  ensure => 'installed'
}

package { 'vim':
  ensure => 'installed'
}

package { 'subversion':
  ensure => 'installed'
}

package { 'ntp':
  ensure => 'installed'
}

package { 'memcached':
  ensure => 'installed'
}

package { 'redis-server':
  ensure => 'installed'
}

class { 'ohmyzsh': }

ohmyzsh::install { 'vagrant': }

class { 'apache':
  require => Apt::Ppa['ppa:ondrej/php5-5.6'],
}

include apache::ssl

apache::dotconf { 'fqdn':
  content => template( '/var/vagrant/conf/fqdn.conf.erb' )
}

apache::module { 'rewrite': }
apache::module { 'cache': }
apache::module { 'cgid': }
apache::module { 'expires': }
apache::module { 'headers': }
apache::module { 'suexec': }
apache::module { 'unique_id': }
apache::module { 'proxy': }
apache::module { 'proxy_fcgi': }
apache::module { 'alias': }

apache::vhost { 'pv':
  docroot => '/var/www/pv',
}

apache::vhost { 'phpmyadmin.pv':
  docroot                  => '/var/www/phpmyadmin.pv/phpmyadmin',
  directory                => '/var/www/phpmyadmin.pv/phpmyadmin',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/conf/vhost.conf.erb',
}

apache::vhost { 'replacedb.pv':
  docroot                  => '/var/www/replacedb.pv',
  directory                => '/var/www/replacedb.pv',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/conf/vhost.conf.erb',
}

apache::vhost { 'core.wordpress.pv':
  docroot                  => '/var/www/core.wordpress.pv/wordpress/src',
  directory                => '/var/www/core.wordpress.pv/wordpress/src',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/conf/vhost.conf.erb',
}

apache::vhost { 'legacy.wordpress.pv':
  docroot                  => '/var/www/legacy.wordpress.pv/htdocs',
  directory                => '/var/www/legacy.wordpress.pv/htdocs',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/conf/vhost.conf.erb',
}

apache::vhost { 'stable.wordpress.pv':
  docroot                  => '/var/www/stable.wordpress.pv/htdocs',
  directory                => '/var/www/stable.wordpress.pv/htdocs',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/conf/vhost.conf.erb',
}

apache::vhost { 'trunk.wordpress.pv':
  docroot                  => '/var/www/trunk.wordpress.pv/htdocs',
  directory                => '/var/www/trunk.wordpress.pv/htdocs',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/conf/vhost.conf.erb',
}

apache::vhost { 'webgrind.pv':
  docroot                  => '/var/www/webgrind.pv',
  directory                => '/var/www/webgrind.pv',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/conf/vhost.conf.erb',
}

class { '::php':
  ensure       => latest,
  manage_repos => true,
  phpunit      => true,
  extensions   => {
    mysql        => { },
    imagick      => { },
    curl         => { },
    gd           => { },
    memcache     => { },
    mcrypt       => { },
    redis        => { },
    xdebug       => {
      zend            => true,
      provider        => 'pecl',
      settings        => {
        'XDEBUG/xdebug.trace_enable_trigger'     => '1',
        'XDEBUG/xdebug.trace_output_dir'         => '/var/xdebug',
        'XDEBUG/xdebug.collect_includes'         => '1',
        'XDEBUG/xdebug.collect_params'           => '1',
        'XDEBUG/xdebug.collect_vars'             => '1',
        'XDEBUG/xdebug.collect_return'           => '1',
        'XDEBUG/xdebug.dump_globals'             => '1',
        'XDEBUG/xdebug.idekey'                   => 'VAGRANT_DEBUG',
        'XDEBUG/xdebug.profiler_enable_trigger'  => '1',
        'XDEBUG/xdebug.profiler_output_name'     => 'cachegrind.out.%t-%s',
        'XDEBUG/xdebug.profiler_output_dir'      => '/var/xdebug',
        'XDEBUG/xdebug.remote_enable'            => '1',
        'XDEBUG/xdebug.remote_mode'              => 'req',
        'XDEBUG/xdebug.remote_host'              => '192.168.13.1',
        'XDEBUG/xdebug.remote_log'               => '/var/xdebug/xdebug-remote.log',
        'XDEBUG/xdebug.remote_autostart'         => '1',
        'XDEBUG/xdebug.remote_port'              => '9000',
        'XDEBUG/xdebug.var_display_max_children' => '-1',
        'XDEBUG/xdebug.var_display_max_data'     => '-1',
        'XDEBUG/xdebug.var_display_max_depth'    => '-1',
        'XDEBUG/xdebug.max_nesting_level'        => '256',
      },
    },
  },
  settings     => {
    'PHP/memory_limit'                       => '256M',
    'PHP/post_max_size'                      => '100M',
    'PHP/upload_max_filesize'                => '100M',
  },
}

exec { 'enabling_mcrypt':
  command => 'php5enmod mcrypt && service apache2 reload',
  require => Package['php5-mcrypt'],
  creates => '/etc/php5/apache2/conf.d/20-mcrypt.ini',
}

exec { 'php_codesniffer':
  command => 'pear install PHP_CodeSniffer',
  require => Class['php'],
  creates => '/usr/bin/phpcs',
}

exec { 'wp_code_standards':
  command => 'git clone -b master https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /var/wpcs && phpcs --config-set installed_paths /var/wpcs',
  require => Class['php'],
  creates => '/var/wpcs/README.md',
}

class { 'nodejs':
  version      => 'latest',
  make_install => false,
}

class { 'postfix':
  relayhost      => '127.0.0.1',
  relayhost_port => '1025',
}

class { 'mysql::server': }

mysql_database { 'stable.wordpress.pv':
  ensure  => 'present',
  charset => 'utf8',
  collate => 'utf8_general_ci',
  require => Class['mysql::server'],
}

mysql_database { 'legacy.wordpress.pv':
  ensure  => 'present',
  charset => 'utf8',
  collate => 'utf8_general_ci',
  require => Class['mysql::server'],
}

mysql_database { 'trunk.wordpress.pv':
  ensure  => 'present',
  charset => 'utf8',
  collate => 'utf8_general_ci',
  require => Class['mysql::server'],
}

mysql_database { 'core.wordpress.pv':
  ensure  => 'present',
  charset => 'utf8',
  collate => 'utf8_general_ci',
  require => Class['mysql::server'],
}

mysql_database { 'tests.core.wordpress.pv':
  ensure  => 'present',
  charset => 'utf8',
  collate => 'utf8_general_ci',
  require => Class['mysql::server'],
}

mysql_user { 'username@localhost':
  ensure        => 'present',
  require       => Class['mysql::server'],
  password_hash => mysql_password(password),
}

mysql_grant { 'username@localhost/*.*':
  ensure     => 'present',
  options    => ['GRANT'],
  privileges => ['ALL'],
  table      => '*.*',
  user       => 'username@localhost',
  require    => Class['mysql::server'],
}

file { '.zshrc':
  path    => '/home/vagrant/.zshrc',
  ensure  => file,
  owner   => 'vagrant',
  group   => 'vagrant',
  source  => '/var/vagrant/conf/.zshrc',
}

file { 'sudoers':
  path    => '/etc/sudoers',
  ensure  => file,
  mode    => '440',
  source  => '/var/vagrant/conf/sudoers',
}

class { 'mailcatcher': }

exec { "wp-cli-/usr/bin":
  command => "wget https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/bin/wp && chmod +x /usr/bin/wp",
  path    => ['/usr/bin' , '/bin'],
  creates => "/usr/bin/wp",
}

vcsrepo { '/var/www/legacy.wordpress.pv/htdocs/wordpress':
  ensure   => present,
  revision => '4.3.3',
  provider => git,
  source   => 'https://github.com/WordPress/WordPress.git',
}

vcsrepo { '/var/www/stable.wordpress.pv/htdocs/wordpress':
  ensure   => present,
  revision => '4.4.2',
  provider => git,
  source   => 'https://github.com/WordPress/WordPress.git',
}

vcsrepo { '/var/www/trunk.wordpress.pv/htdocs/wordpress':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/WordPress/WordPress.git',
}

vcsrepo { '/var/www/core.wordpress.pv/wordpress':
  ensure   => latest,
  provider => git,
  source   => 'git://develop.git.wordpress.org/',
}

vcsrepo { '/var/www/phpmyadmin.pv/phpmyadmin':
  ensure   => present,
  revision => 'RELEASE_4_6_0',
  provider => git,
  source   => 'https://github.com/phpmyadmin/phpmyadmin.git',
} ->
file { '/var/www/phpmyadmin.pv/phpmyadmin/config.inc.php':
  ensure => 'link',
  target => '/var/www/phpmyadmin.pv/config.inc.php',
}

vcsrepo { '/var/www/trunk.wordpress.pv/htdocs/content/plugins/any-ipsum':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/petenelson/wp-any-ipsum.git',
}

vcsrepo { '/var/www/trunk.wordpress.pv/htdocs/content/plugins/debug-bar':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/wp-mirrors/debug-bar.git',
}

vcsrepo { '/var/www/trunk.wordpress.pv/htdocs/content/plugins/heartbeat-control':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/JeffMatson/heartbeat-control.git',
}

vcsrepo { '/var/www/trunk.wordpress.pv/htdocs/content/plugins/query-monitor':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/johnbillion/query-monitor.git',
}

vcsrepo { '/var/www/trunk.wordpress.pv/htdocs/content/plugins/whats-running':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/szepeviktor/whats-running.git',
}

vcsrepo { '/var/www/webgrind.pv':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/jokkedk/webgrind.git',
}

vcsrepo { '/var/www/replacedb.pv':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/interconnectit/Search-Replace-DB.git',
}

vcsrepo { '/var/www/trunk.wordpress.pv/htdocs/content/wp-test':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/manovotny/wptest.git',
}

import 'sites/*.pp'
