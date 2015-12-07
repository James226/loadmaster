require 'net/http'
require 'rexml/document'
include REXML

Puppet::Type.type(:lm_realserver).provide(:ruby) do
  def exists?
      url = "https://#{resource[:host_ip]}/access/showrs?vs=#{resource[:virtual_ip]}&port=#{resource[:virtual_port]}&prot=#{resource[:virtual_protocol]}&rs=#{resource[:ip]}&rsport=#{resource[:port]}"

      response = Document.new webrequest(url, resource[:host_username], resource[:host_password])
#       response = Document.new <<EOF
#       <Response stat="422" code="fail">
#       <Error>Unknown VS</Error>
#       </Response>
# EOF

      if response.root.attributes["code"] == "fail"
          raise Puppet::ParseError, "Failed to query load master, response code: #{response.root.attributes["stat"]}" if response.root.attributes["stat"] != "422"
          return false
      end
      return true
  end

  def create
      puts "Creating real server '#{resource[:name]}'"
      url = "https://#{resource[:host_ip]}/access/addrs?vs=#{resource[:virtual_ip]}&port=#{resource[:virtual_port]}&prot=#{resource[:virtual_protocol]}&rs=#{resource[:ip]}&rsport=#{resource[:port]}"
      response = Document.new webrequest(url, resource[:host_username], resource[:host_password])
#       response = Document.new <<EOF
#       <Response stat="422" code="success">
#       <Error>Unknown VS</Error>
#       </Response>
# EOF

      if response.root.attributes["code"] == "fail"
          raise Puppet::ParseError, "Failed to create real server '#{resource[:name]}', response code: #{response.root.attributes['stat']}"
      end
  end

  def destroy
      puts "Deleting real server '#{resource[:name]}'"
      url = "https://#{resource[:host_ip]}/access/delrs?vs=#{resource[:virtual_ip]}&port=#{resource[:virtual_port]}&prot=#{resource[:virtual_protocol]}&rs=#{resource[:ip]}&rsport=#{resource[:port]}"

      response = Document.new webrequest(url, resource[:host_username], resource[:host_password])
#         response = Document.new <<EOF
#         <Response stat="422" code="success">
#         <Error>Unknown VS</Error>
#         </Response>
# EOF

      if response.root.attributes["code"] == "fail"
          raise Puppet::ParseError, "Failed to delete real server '#{resource[:name]}', response code: #{response.root.attributes['stat']}"
      end
  end

  def webrequest(url, username, password)
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
