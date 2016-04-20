import 'helpers/*.pp'

group { 'puppet': ensure => present }

Exec { path => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/', '/var/vagrant/bin/' ] }
File { owner => 0, group => 0, mode => 0644 }


