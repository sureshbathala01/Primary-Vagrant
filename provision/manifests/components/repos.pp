vcsrepo { '/var/www/legacy.wordpress.pv/htdocs/wordpress':
  ensure   => present,
  revision => '4.4.2',
  provider => git,
  source   => 'https://github.com/WordPress/WordPress.git',
}

vcsrepo { '/var/www/stable.wordpress.pv/htdocs/wordpress':
  ensure   => present,
  revision => '4.5.1',
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

vcsrepo { '/var/www/trunk.wordpress.pv/htdocs/content/plugins/debug-bar-remote-requests':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/alleyinteractive/debug-bar-remote-requests.git',
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

vcsrepo { '/var/www/vip.wordpress.pv/wp':
  ensure   => present,
  provider => svn,
  source   => 'http://core.svn.wordpress.org/trunk/',
}

vcsrepo { '/var/www/vip.wordpress.pv/wp-tests':
  ensure   => present,
  provider => svn,
  source   => 'http://develop.svn.wordpress.org/trunk/',
}

vcsrepo { '/var/www/trunk.wordpress.pv/htdocs/content/wp-test':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/manovotny/wptest.git',
}

vcsrepo { '/var/www/vip.wordpress.pv/wp-content/themes/vip/plugins':
  ensure   => latest,
  source   => 'https://vip-svn.wordpress.com/plugins/',
  provider => svn,
}

vcsrepo { '/var/www/vip.wordpress.pv/wp-content/themes/pub/twentyfifteen':
  ensure   => latest,
  source   => 'https://wpcom-themes.svn.automattic.com/twentyfifteen',
  provider => svn,
}