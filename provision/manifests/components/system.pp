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

class { 'ohmyzsh': }

ohmyzsh::install { 'vagrant': }

class { 'nodejs':
  version      => 'latest',
  make_install => false,
}

file { '.zshrc':
  path    => '/home/vagrant/.zshrc',
  ensure  => file,
  owner   => 'vagrant',
  group   => 'vagrant',
  source  => '/var/vagrant/lib/conf/.zshrc',
}

file { 'sudoers':
  path    => '/etc/sudoers',
  ensure  => file,
  mode    => '440',
  source  => '/var/vagrant/lib/conf/sudoers',
}