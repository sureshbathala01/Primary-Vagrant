class { 'php':
  service => 'apache'
}

class { 'php::devel':
  require => Class['php'],
}

class { 'phpunit':
  require => Class['php'],
}

php::module { 'mysql': }
php::module { 'cli': }
php::module { 'curl': }
php::module { 'gd': }
php::module { 'imagick': }
php::module { 'mcrypt': }
php::pecl::module { 'xdebug': }

exec { 'enabling_mcrypt':
  command => 'php5enmod mcrypt && service apache2 reload',
  require => Package['php5-mcrypt'],
  creates => '/etc/php5/apache2/conf.d/20-mcrypt.ini',
}

exec { 'php_codesniffer':
  command => 'pear install PHP_CodeSniffer',
  require => Package['php5-mcrypt'],
  creates => '/usr/bin/phpcs',
}

exec { 'wp_code_standards':
  command => 'git clone -b master https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards.git /var/wpcs && phpcs --config-set installed_paths /var/wpcs',
  require => Package['php5-mcrypt'],
  creates => '/var/wpcs/README.md',
}

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
  'php-xdebug.max_nesting_level':
    entry   => 'XDEBUG/xdebug.max_nesting_level',
    value   => '256',
    require => Class['php'];
  'php-memory_limit':
    entry   => 'PHP/memory_limit',
    value   => '256M',
    require => Class['php'];
  'php-post_max_size':
    entry   => 'PHP/post_max_size',
    value   => '100M',
    require => Class['php'];
  'php-upload_max_filesize':
    entry   => 'PHP/upload_max_filesize',
    value   => '100M',
    require => Class['php'];
}

class { 'composer':
  command_name => 'composer',
  target_dir   => '/usr/local/bin',
  auto_update  => true,
}