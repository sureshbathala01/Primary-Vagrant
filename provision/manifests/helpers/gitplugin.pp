# GitPlugin clones a git repo into the www/wp-content/plugins directory and activates it in WordPress
# Taken from Automattic's VIP Quickstart (https://github.com/Automattic/vip-quickstart)
define gitplugin ( $git_urls ) {
  vcsrepo { "/var/www/vip.wordpress.pv/wp-content/plugins/${title}" :
    ensure   => present,
    force    => true,
    source   => $git_urls[$title],
    provider => git,
    require  => [
      Wp::Site['/var/www/vip.wordpress.pv/wp'],
    ]
  }

  wp::command { "plugin activate ${title}":
    command  => "plugin activate ${title} --network",
    location => '/var/www/vip.wordpress.pv/wp',
    require  => Vcsrepo["/var/www/vip.wordpress.pv/wp-content/plugins/${title}"],
  }
}
