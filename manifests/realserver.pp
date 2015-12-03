define loadmaster::realserver ($vs, $ip, $port) {
  $vs_ip = getparam($vs, "ip")
  $vs_port = getparam($vs, "port")
  $vs_prot = getparam($vs, "protocol")
  
  $url = "https://${loadmaster::ip}/access/addrs?vs=${vs_ip}&port=${vs_port}&prot=${vs_prot}&rs=${ip}&rsport=${port}"
  webrequest($url, $loadmaster::username, $loadmaster::password)
}
