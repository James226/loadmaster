define loadmaster::virtualservice ($ip, $port, $protocol) {
  webrequest("https://${loadmaster::ip}/access/addvs?vs=${ip}&port=${port}&prot=${protocol}&nickname=${name}", $loadmaster::username, $loadmaster::password)
}
