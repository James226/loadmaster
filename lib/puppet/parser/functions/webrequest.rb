require 'net/http'

module Puppet::Parser::Functions
  newfunction(:webrequest) do |args|
    url = args[0]
    username = args[1]
    password = args[2]
    puts "Invoking web request: #{url}"
    url = URI.parse(url)
    req = Net::HTTP::Get.new(url.to_s)
    req.basic_auth(username,password)
    res = Net::HTTP.start(url.host, url.port,
                          :use_ssl => url.scheme == 'https',
                          :verify_mode => OpenSSL::SSL::VERIFY_NONE) {|http|
      http.request(req)
    }
    puts res.body
  end
end
