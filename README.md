Primary Vagrant
=============

##Note

I've done some heavy updates to Primary Vagrant to utilize Ubuntu 14.04 as well as a few other goodies. If you don't want to or can't update for some reason you can fine the old version in the [Precise](https://github.com/ChrisWiegman/Primary-Vagrant/tree/Precise) branch.

##About

[Varying Vagrant Vagrants](https://github.com/Varying-Vagrant-Vagrants/VVV) by 10-up is great (and I still use it for NGINX work), but I wanted a few major changes. First, I wanted Apache instead of NGINX and, second, I wanted to use Puppet instead of Bash. Using VVV and Puppet as a base this repository attempts to address their shortcomings for my own work with a Vagrant configuration that is ready to go for WordPress plugin or theme development.

The repository contains a basic Vagrant configuration that will configure the following goodies:

* Ubuntu 14.04 LTS
* Apache
* PHP 5.5
* MySQL
* Xdebug
* PHPUnit
* Postfix
* wp-cli
* phpMyAdmin
* WordPress (Last, Stable, Core and Dev)
* wp-debug plugin
* [Search Replace DB](http://interconnectit.com/products/search-and-replace-for-wordpress-databases/)
* [webgrind](https://github.com/jokkedk/webgrind/)
* [oh-my-zsh](http://ohmyz.sh)
* [MailCatcher](http://mailcatcher.me)

##Getting Started

### Default domains

* pv - Default menu
* phpmyadmin.pv - phpMyAdmin
* replacedb.pv - Search Replace DB
* wordpress.core.pv - WordPress Development (for core dev)
* wordpress.legacy.pv - Last version of WordPress (currently 3.8.3)
* wordpress.stable.pv - latest WordPress stable (currently 3.9.1)
* wordpress.trunk.pv - WordPress trunk
* webgrind.pv - webgrind
* mailcatcher.pv - MailCatcher

###Install the software

Install [Vagrant](http://vagrantup.com), [VirtualBox](http://virtualbox.org) and the [VirtualBox extensions](https://www.virtualbox.org/wiki/Downloads) for your environment.

Once Vagrant is installed you'll want two plugins to update your local hosts file and update the VirtualBox Guest additions in the Ubuntu install

```vagrant plugin install vagrant-vbguest```

```vagrant plugin install vagrant-hostsupdater```

###Launch your VM

1. Download or clone this repo on your local machine
2. run ```vagrant up``` from the folder where you're storing this repository

###Preconfigured Sites

The following websites come pre-configured in the system:

* [The mail menu](http://pv)

* WordPress (latest stable release) at [http://wordpress.stable.pv](http://wordpress.stable.pv)
* WordPress Trunk at [http://wordpress.trunk.pv](http://wordpress.trunk.pv)
* WordPress Core Development at [http://wordpress.core.pv](http://wordpress.core.pv)
* Search Replace DB [https://www.virtualbox.org/wiki/Downloads](https://replacedb.pv)

*Note: WordPress Core dev is taken from git://develop.git.wordpress.org/. Only the src folder is mapped. You can manually set up a build site if desired.

###Configure your Apache VirtualHosts

Edit the file **Vagrantfile** and add paths to your own websites as well as a host entry to reach it

Edit **manifests/whosts.pp**. This is where you define virtualhosts and databases. Copy what is there and ask me if you have any questions.

example:

```apache::vhost { 'mysite.pv':
	docroot       				=> 'path/to/your/site',
	directory					=> 'path/to/your/site',
	directory_allow_override	=> 'All',
	ssl							=> true,
	template                    => '/var/vagrant/conf/vhost.conf.erb',
}```

*Note: I've provided a top-level wildcard SSL certificatate. No further SSL certificate should be needed.

###Change PHP Versions

To change from PHP 5.5 I recommend using a PGP package from [https://launchpad.net/~ondrej/+archive/php5](https://launchpad.net/~ondrej/+archive/php5). You can do so by adding  ```apt::ppa { 'ppa:ondrej/php5': }``` to *manifests/php.pp*. Make sure to choose the correct repository for the PHP version you want to use.

Note this file can also be used to change any php.ini value following the example included in the file.

###Database Access

You can access the database via ssh tunnel into the machine using the *local.vagrant* hostname and the username *vagrant* and the password *vagrant* for ssh and the username *root* without a password for MySQL

In addition to the *root* MySQL account the account *username* with the password *password* has also been created and has been granted all privileges.

To create a new database use the following example to edit manifests/mysql.pp

```mysql_database { 'database_name':
     ensure  => 'present',
     charset => 'utf8',
     collate => 'utf8_swedish_ci',
}```

###Postfix Configuration

Postfix is configured and set to use your host computer as a mail relay. To receive messages you can use the built in [MailCatcher installation](http://mailcatcher.pv:1080) (this will prevent your real SMTP mail server and mailbox from getting too much abuse).

##Note

This server configuration is designed for developmental use only. Please don't put it on a production server as some of these settings would cause serious security issues.
