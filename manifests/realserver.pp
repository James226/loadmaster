define loadmaster::realserver ($vs, $ip, $port, $ensure) {
    $host = getparam($vs, "host")
  lm_realserver { $name:
      host_ip => getparam($host, "title"),
      host_username => getparam($host, "username"),
      host_password => getparam($host, "password"),

      virtual_ip => getparam($vs, "ip"),
      virtual_port => getparam($vs, "port"),
      virtual_protocol => getparam($vs, "protocol"),

      ip => $ip,
      port => $port,

      ensure => $ensure,
      require => $host
  }
}
