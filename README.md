Primary Vagrant
=============

[Varying Vagrant Vagrants](https://github.com/Varying-Vagrant-Vagrants/VVV) by 10-up is great, but I wanted a few major changes. First, I wanted Apache instead of NGINX and, second, I wanted to use Puppet instead of Bash. Using VVV and Puphet as a base this repository attempts to address their shortcomings for my own work with a Vagrant configuration that is ready to go for WordPress plugin or theme development.

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
* WordPress (Stable and Core)
* [Search Replace DB](http://interconnectit.com/products/search-and-replace-for-wordpress-databases/)
* [webgrind](https://github.com/jokkedk/webgrind/)
* [oh-my-zsh](http://ohmyz.sh)

##Getting Started

### Default domains

* pv - Default menu
* phpmyadmin.vagrant - phpMyAdmin
* replacedb.vagrant - Search Replace DB
* stable.wordpress.vagrant - latest WordPress stable
* trunk.wordpress.vagrant - WordPress trunk
* webgrind.vagrant - webgrind

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

* WordPress (latest stable release) at [http://stable.wordpress.vagrant](http://stable.wordpress.vagrant)
* WordPress Trunk at [http://trunk.wordpress.vagrant](http://trunk.wordpress.vagrant)
* Search Replace DB [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

###Configure your Apache VirtualHosts

Edit the file **Vagrantfile** and add paths to your own websites as well as a host entry to reach it

Edit **manifests/whosts.pp**. This is where you define virtualhosts and databases. Copy what is there and ask me if you have any questions.

example:

```apache::vhost { 'hostname.whatever':
	docroot       				=> 'path/to/your/site',
	directory					=> 'path/to/your/site',
	directory_allow_override	    => 'All',
	ssl							=> true,
	template                     => '/var/vagrant/conf/vhost.conf.erb',
}```

*Note: if using ssl you will need to add a custom ssl certificate with the name of hostname to the ssl folder in the repository directory and make sure you don't delete the template line above.*

###Change PHP Versions

To change from PHP 5.5 remove the line ```apt::ppa { 'ppa:ondrej/php5': }``` from *manifests/php.pp*. This will install the default PHP 5.3.

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

Postfix is configured and set to use your host computer as a mail relay. To receive messages you will need an application such as [MockSmtp](http://mocksmtpapp.com) on your host computer configured to listen on port 1025

##Note

This server configuration is designed for developmental use only. Please don't put it on a production server as some of these settings would cause serious security issues.
