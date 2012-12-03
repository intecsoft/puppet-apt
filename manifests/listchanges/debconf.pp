define apt::listchanges::debconf(
  $setting = $name,
  $value
) {
  exec { "debconf set ${setting} to ${value}":
    command => "echo 'set ${setting} ${value}' | debconf-communicate",
    onlyif  => "test \"$(echo 'get ${setting}' | debconf-communicate)\" != \"0 ${value}\"",
    notify  => Exec['dpkg-reconfigure apt-listchanges'],
    require => Package['apt-listchanges'],
  }
}
