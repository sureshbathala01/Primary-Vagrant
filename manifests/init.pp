group { 'puppet': ensure => present }

Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ] }
File { owner => 0, group => 0, mode => 0644 }

class { 'apt':
	always_apt_update => true,
}

Class['::apt::update'] -> Package <|
	title != 'python-software-properties'
	and title != 'software-properties-common'
|>

package { 'vim':
	ensure => 'installed'
}

package { 'ntp':
	ensure => 'installed'
}

class { 'ohmyzsh': }
ohmyzsh::install { 'vagrant': }

class { 'apache': }

include apache::ssl

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
	template                 => '/var/vagrant/conf/vhost.conf.erb',
}

apache::vhost { 'wordpress.core.pv':
	docroot                  => '/var/www/wordpress.core.pv/src',
	directory                => '/var/www/wordpress.core.pv/src',
	directory_allow_override => 'All',
	ssl                      => true,
	template                 => '/var/vagrant/conf/vhost.conf.erb',
}

apache::vhost { 'wordpress.legacy.pv':
	docroot                  => '/var/www/wordpress.legacy.pv/htdocs',
	directory                => '/var/www/wordpress.legacy.pv/htdocs',
	directory_allow_override => 'All',
	ssl                      => true,
	template                 => '/var/vagrant/conf/vhost.conf.erb',
}

apache::vhost { 'wordpress.stable.pv':
	docroot                  => '/var/www/wordpress.stable.pv/htdocs',
	directory                => '/var/www/wordpress.stable.pv/htdocs',
	directory_allow_override => 'All',
	ssl                      => true,
	template                 => '/var/vagrant/conf/vhost.conf.erb',
}

apache::vhost { 'wordpress.trunk.pv':
	docroot                  => '/var/www/wordpress.trunk.pv/htdocs',
	directory                => '/var/www/wordpress.trunk.pv/htdocs',
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

class { 'php':
	service             => 'apache',
	service_autorestart => false,
	module_prefix       => '',
}

class { 'php::devel':
	require => Class['php'],
}

class { 'phpunit':
	require => Class['php'],
}

php::module { 'php5-mysql': }
php::module { 'php5-cli': }
php::module { 'php5-curl': }
php::module { 'php5-gd': }
php::module { 'php5-imagick': }
php::module { 'php-apc': }
php::pecl::module { 'xdebug': }

php::augeas {
	'php-xdebug.trace_enable_trigger':
		entry   => 'XDEBUG/xdebug.trace_enable_trigger',
		value   => '1',
		require => Class['php'];
	'xdebug.trace_output_dir':
		entry   => 'XDEBUG/xdebug.trace_output_dir',
		value   => '/var/xdebug',
		require => Class['php'];
	'php-xdebug.collect_includes':
		entry   => 'XDEBUG/xdebug.collect_includes',
		value   => '1',
		require => Class['php'];
	'php-xdebug.collect_params':
		entry   => 'XDEBUG/xdebug.collect_params',
		value   => '1',
		require => Class['php'];
	'php-xdebug.collect_vars':
		entry   => 'XDEBUG/xdebug.collect_vars',
		value   => '1',
		require => Class['php'];
	'php-xdebug.collect_return':
		entry   => 'XDEBUG/xdebug.collect_return',
		value   => '1',
		require => Class['php'];
	'php-xdebug.dump_globals':
		entry   => 'XDEBUG/xdebug.dump_globals',
		value   => '1',
		require => Class['php'];
	'php-xdebug.idekey':
		entry   => 'XDEBUG/xdebug.idekey',
		value   => 'VAGRANT_DEBUG',
		require => Class['php'];
	'php-xdebug.profiler_enable_trigger':
		entry   => 'XDEBUG/xdebug.profiler_enable_trigger',
		value   => '1',
		require => Class['php'];
	'php-xdebug.profiler_output_name':
		entry   => 'XDEBUG/xdebug.profiler_output_name',
		value   => 'cachegrind.out.%t-%s',
		require => Class['php'];
	'php-xdebug.profiler_output_dir':
		entry   => 'XDEBUG/xdebug.profiler_output_dir',
		value   => '/var/xdebug',
		require => Class['php'];
	'php-xdebug.remote_enable':
		entry   => 'XDEBUG/xdebug.remote_enable',
		value   => '1',
		require => Class['php'];
	'php-xdebug.remote_mode':
		entry   => 'XDEBUG/xdebug.remote_mode',
		value   => 'req',
		require => Class['php'];
	'php-xdebug.remote_host':
		entry   => 'XDEBUG/xdebug.remote_host',
		value   => '192.168.13.1',
		require => Class['php'];
	'php-xdebug.remote_log':
		entry   => 'XDEBUG/xdebug.remote_log',
		value   => '/var/xdebug/xdebug-remote.log',
		require => Class['php'];
	'php-xdebug.remote_port':
		entry   => 'XDEBUG/xdebug.remote_port',
		value   => '9000',
		require => Class['php'];
	'php-xdebug.var_display_max_children':
		entry   => 'XDEBUG/xdebug.var_display_max_children',
		value   => '-1',
		require => Class['php'];
	'php-xdebug.var_display_max_data':
		entry   => 'XDEBUG/xdebug.var_display_max_data',
		value   => '-1',
		require => Class['php'];
	'php-xdebug.var_display_max_depth':
		entry   => 'XDEBUG/xdebug.var_display_max_depth',
		value   => '-1',
		require => Class['php'];
}

class { 'wp-cli': }

class { 'postfix':
	relayhost      => '127.0.0.1',
	relayhost_port => '1025',
}

class { 'mysql::server':
	remove_default_accounts => true,
}

mysql_database { 'wordpress.stable.pv':
	ensure  => 'present',
	charset => 'utf8',
	collate => 'utf8_swedish_ci',
	require => Class['mysql::server'],
}

mysql_database { 'wordpress.legacy.pv':
	ensure  => 'present',
	charset => 'utf8',
	collate => 'utf8_swedish_ci',
	require => Class['mysql::server'],
}

mysql_database { 'wordpress.trunk.pv':
	ensure  => 'present',
	charset => 'utf8',
	collate => 'utf8_swedish_ci',
	require => Class['mysql::server'],
}

mysql_database { 'wordpress.core.pv':
	ensure  => 'present',
	charset => 'utf8',
	collate => 'utf8_swedish_ci',
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

class { 'mailcatcher': }

file { '/var/www/phpmyadmin.pv/phpmyadmin/config.inc.php':
	ensure => 'link',
	target => '/var/www/phpmyadmin.pv/config.inc.php',
}

import 'custom/*.pp'
