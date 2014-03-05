# Note: that much of the documentation in this file is from Varying Vagrant Vagrants, the original base for this project

Vagrant.configure("2") do |config|
	
	# Store the current version of Vagrant for use in conditionals when dealing
		# with possible backward compatible issues.
		vagrant_version = Vagrant::VERSION.sub(/^v/, '')

	# Default Ubuntu Box
	# 
	# This box is provided directly by Canonical and is updated almost nightly. Currently it is
	# configured to use Ubuntu 12.04 x64. For a full list of boxes provided by Canonical visit
	# http://cloud-images.ubuntu.com/vagrant/
	config.vm.box = "precise32"
	config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-i386-vagrant-disk1.box"

	config.vm.hostname = "local.vagrant"

	# Default Box IP Address
	#
	# This is the IP address that your host will communicate to the guest through. In the
	# case of the default `192.168.56.101` that we've provided, Virtualbox will setup another
	# network adapter on your host machine with the IP `192.168.56.1` as a gateway.
	#
	# If you are already on a network using the 192.168.56.x subnet, this should be changed.
	# If you are running more than one VM through Virtualbox, different subnets should be used
	# for those as well. This includes other Vagrant boxes.
	config.vm.network :private_network, ip: "192.168.56.101"
	
	# Local Machine Hosts
	#
	# If the Vagrant plugin hostsupdater (https://github.com/cogitatio/vagrant-hostsupdater) is
	# installed, the following will automatically configure your local machine's hosts file to
	# be aware of the domains specified below. Watch the provisioning script as you may be
	# required to enter a password for Vagrant to access your hosts file.
	if defined? VagrantPlugins::HostsUpdater
		config.hostsupdater.aliases = [
			"phpmyadmin.vagrant",
			"replacedb.vagrant",
			"stable.wordpress.vagrant",
			"trunk.wordpress.vagrant",
		]
	end

	# Forward Agent
	#
	# Enable agent forwarding on vagrant ssh commands. This allows you to use identities
	# established on the host machine inside the guest. See the manual for ssh-add
	config.ssh.forward_agent = true

	# Configurations from 1.0.x can be placed in Vagrant 1.1.x specs like the following.
	config.vm.provider :virtualbox do |v|
		v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		v.customize ["modifyvm", :id, "--memory", 512]
		v.customize ["modifyvm", :id, "--name", "Primary Vagrant"]
	end

	# Drive mapping
	#
	# The following config.vm.share_folder settings will map directories in your Vagrant
	# virtual machine to directories on your local machine. Once these are mapped, any
	# changes made to the files in these directories will affect both the local and virtual
	# machine versions. Think of it as two different ways to access the same file. When the
	# virtual machine is destroyed with `vagrant destroy`, your files will remain in your local
	# environment.

	# /var/www/
	# 
	# For each project you're working on map a folder to it. The first argument is the location
	# on the host computer. The second argument is the location on the guest matching. Finally the 
	# 3rd arguement is a unique ID given to each folder mapped
	config.vm.synced_folder "sites/stable.wordpress.vagrant", "/var/www/stable.wordpress.vagrant", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774" ]
	config.vm.synced_folder "sites/stable.wordpress.vagrant/uploads", "/var/www/stable.wordpress.vagrant/wordpress/wp-content/uploads", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774" ]
	config.vm.synced_folder "sites/trunk.wordpress.vagrant", "/var/www/trunk.wordpress.vagrant", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774" ]
	config.vm.synced_folder "sites/trunk.wordpress.vagrant/uploads", "/var/www/trunk.wordpress.vagrant/wordpress/wp-content/uploads", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774" ]
	config.vm.synced_folder "sites/Search-Replace-DB", "/var/www/replacedb.vagrant", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774" ]
	config.vm.synced_folder "sites/phpmyadmin", "/var/www/phpmyadmin.vagrant", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774" ]

	# /Vagrant Data
	# 
	# Specify a folder for various vagrant data. A MySQL data folder would be appropriate here (for example).
	config.vm.synced_folder "xdebug", "/var/xdebug", :mount_options => [ "dmode=777", "fmode=777" ]
 	config.vm.synced_folder "ssl", "/etc/apache2/ssl", :mount_options => [ "dmode=777", "fmode=777" ]
 	config.vm.synced_folder "conf", "/var/vagrant/conf", :mount_options => [ "dmode=777", "fmode=777" ]
 	config.vm.synced_folder "mysql", "/var/lib/mysql", :mount_options => [ "dmode=777", "fmode=777" ]

 	# Custom Mappings
 	#
 	# Use this section to specifiy custom mapptings for your own development.

	# Provisioning
	#
	# Process one or more provisioning scripts depending on the existence of custom files.
	# 
	# Provisioning uses the Puppet configuration tool (http://puppetlabs.com/). This tool
	# relies on modules in the modules/ folder which are configures in manifests/default.pp.
	config.vm.provision :puppet do |puppet|
		puppet.manifests_path = "manifests"
		puppet.manifest_file = "init.pp"
		puppet.module_path = "modules"
		puppet.facter = { "fqdn" => "local.vagrant" }
	end


end
