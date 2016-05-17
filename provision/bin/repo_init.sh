#!/bin/bash

# WordPress Trunk
if [ ! -d "www/default/wordpress/trunk/htdocs/wordpress/.git" ]; then
  git clone https://github.com/WordPress/WordPress.git www/default/wordpress/trunk/htdocs/wordpress
fi

# WordPress Stable
if [ ! -d "www/default/wordpress/stable/htdocs/wordpress/.git" ]; then
  git clone https://github.com/WordPress/WordPress.git www/default/wordpress/stable/htdocs/wordpress
fi

# WordPress Legacy
if [ ! -d "www/default/wordpress/legacy/htdocs/wordpress/.git" ]; then
  git clone https://github.com/WordPress/WordPress.git www/default/wordpress/legacy/htdocs/wordpress
fi

# WordPress Core
if [ ! -d "www/default/wordpress/core/wordpress/.git" ]; then
  git clone git://develop.git.wordpress.org/ www/default/wordpress/core/wordpress
fi

# WordPress Plugin Any Ipsum
if [ ! -d "www/default/wordpress/content/plugins/any-ipsum/.git" ]; then
  git clone https://github.com/petenelson/wp-any-ipsum.git www/default/wordpress/content/plugins/any-ipsum
fi

# WordPress Plugin Debug Bar
if [ ! -d "www/default/wordpress/content/plugins/debug-bar/.git" ]; then
  git clone https://github.com/wp-mirrors/debug-bar.git www/default/wordpress/content/plugins/debug-bar
fi

# WordPress Plugin Heartbeat Control
if [ ! -d "www/default/wordpress/content/plugins/heartbeat-control/.git" ]; then
  git clone https://github.com/JeffMatson/heartbeat-control.git www/default/wordpress/content/plugins/heartbeat-control
fi

# WordPress Plugin Query Monitor
if [ ! -d "www/default/wordpress/content/plugins/query-monitor/.git" ]; then
  git clone https://github.com/johnbillion/query-monitor.git www/default/wordpress/content/plugins/query-monitor
fi

# WordPress Plugin What's Running
if [ ! -d "www/default/wordpress/content/plugins/whats-running/.git" ]; then
  git clone https://github.com/szepeviktor/whats-running.git www/default/wordpress/content/plugins/whats-running
fi

# WordPress Plugin What's Running
if [ ! -d "www/default/wordpress/content/plugins/debug-bar-remote-requests/.git" ]; then
  git clone https://github.com/alleyinteractive/debug-bar-remote-requests.git www/default/wordpress/content/plugins/debug-bar-remote-requests
fi

# WP-Test
if [ ! -d "www/default/wordpress/content/wp-test/.git" ]; then
  git clone https://github.com/manovotny/wptest.git www/default/wordpress/content/wp-test
fi

# PhpMyAdmin
if [ ! -d "www/default/phpmyadmin/phpmyadmin/.git" ]; then
  git clone https://github.com/phpmyadmin/phpmyadmin.git www/default/phpmyadmin/phpmyadmin
fi