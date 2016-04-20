class { 'postfix':
  relayhost      => '127.0.0.1',
  relayhost_port => '1025',
}

class { 'mailcatcher': }