define loadmaster::virtualservice ($host, $ip, $port, $protocol, $ensure) {
  lm_virtualservice { $name:
      host_ip => getparam($host, "title"),
      host_username => getparam($host, "username"),
      host_password => getparam($host, "password"),

      ip => $ip,
      port => $port,
      protocol => $protocol,
      
      ensure => $ensure,
      require => $host
  }
}
