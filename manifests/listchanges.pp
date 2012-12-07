class apt::listchanges(
  $email_address = 'root'
) {

  package{ 'apt-listchanges':
    ensure => installed,
    # populates debconf Database with default values?!
    notify => Exec['dpkg-reconfigure apt-listchanges'],
  }

  apt::listchanges::debconf{ 'apt-listchanges/frontend':
    value => 'mail',
  }
  apt::listchanges::debconf{ 'apt-listchanges/confirm':
    value => 'false',
  }
  apt::listchanges::debconf{ 'apt-listchanges/which':
    value => 'both',
  }
  apt::listchanges::debconf{ 'apt-listchanges/email-address':
    value => $email_address,
  }
  apt::listchanges::debconf{ 'apt-listchanges/save-seen':
    value => 'true',
  }

  exec { 'dpkg-reconfigure apt-listchanges':
    command     => 'dpkg-reconfigure -fnoninteractive apt-listchanges',
    refreshonly => true,
    path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    require     => Package['apt-listchanges'],
  }

}
