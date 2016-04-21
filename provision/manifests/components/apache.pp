class { 'apache':
  require => Apt::Ppa['ppa:ondrej/php5-5.6'],
}

include apache::ssl

apache::dotconf { 'fqdn':
  content => template( '/var/vagrant/lib/conf/fqdn.conf.erb' )
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
  docroot  => '/var/www/pv',
  template => '/var/vagrant/lib/conf/vhost.conf.erb',
}

apache::vhost { 'phpmyadmin.pv':
  docroot                  => '/var/www/phpmyadmin.pv/phpmyadmin',
  directory                => '/var/www/phpmyadmin.pv/phpmyadmin',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/lib/conf/vhost.conf.erb',
}

apache::vhost { 'replacedb.pv':
  docroot                  => '/var/www/replacedb.pv',
  directory                => '/var/www/replacedb.pv',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/lib/conf/vhost.conf.erb',
}

apache::vhost { 'core.wordpress.pv':
  docroot                  => '/var/www/core.wordpress.pv/wordpress/src',
  directory                => '/var/www/core.wordpress.pv/wordpress/src',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/lib/conf/vhost.conf.erb',
}

apache::vhost { 'legacy.wordpress.pv':
  docroot                  => '/var/www/legacy.wordpress.pv/htdocs',
  directory                => '/var/www/legacy.wordpress.pv/htdocs',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/lib/conf/vhost.conf.erb',
}

apache::vhost { 'stable.wordpress.pv':
  docroot                  => '/var/www/stable.wordpress.pv/htdocs',
  directory                => '/var/www/stable.wordpress.pv/htdocs',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/lib/conf/vhost.conf.erb',
}

apache::vhost { 'trunk.wordpress.pv':
  docroot                  => '/var/www/trunk.wordpress.pv/htdocs',
  directory                => '/var/www/trunk.wordpress.pv/htdocs',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/lib/conf/vhost.conf.erb',
}

apache::vhost { 'vip.wordpress.pv':
  docroot                  => '/var/www/vip.wordpress.pv',
  directory                => '/var/www/vip.wordpress.pv',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/lib/conf/vhost.conf.erb',
}

apache::vhost { 'webgrind.pv':
  docroot                  => '/var/www/webgrind.pv',
  directory                => '/var/www/webgrind.pv',
  directory_allow_override => 'All',
  ssl                      => true,
  template                 => '/var/vagrant/lib/conf/vhost.conf.erb',
}