require 'net/http'
require 'rexml/document'
include REXML

Puppet::Type.type(:lm_virtualservice).provide(:ruby) do
  def exists?
      url = "https://#{resource[:host_ip]}/access/showvs?vs=#{resource[:ip]}&port=#{resource[:port]}&prot=#{resource[:protocol]}"

      response = Document.new webrequest(url, resource[:host_username], resource[:host_password])
#       response = Document.new <<EOF
#       <Response stat="422" code="success">
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
      puts "Creating virtual service '#{resource[:name]}'"
      url = "https://#{resource[:host_ip]}/access/addvs?vs=#{resource[:ip]}&port=#{resource[:port]}&prot=#{resource[:protocol]}"

       response = Document.new webrequest(url, resource[:host_username], resource[:host_password])
#       response = Document.new <<EOF
#       <Response stat="422" code="success">
#       <Error>Unknown VS</Error>
#       </Response>
# EOF

      if response.root.attributes["code"] == "fail"
          raise Puppet::ParseError, "Failed to create virtual service '#{resource[:name]}', response code: #{response.root.attributes['stat']}"
      end
  end

  def destroy
      puts "Deleting virtual service '#{resource[:name]}'"
      url = "https://#{resource[:host_ip]}/access/delvs?vs=#{resource[:ip]}&port=#{resource[:port]}&prot=#{resource[:protocol]}"

      response = Document.new webrequest(url, resource[:host_username], resource[:host_password])
#         response = Document.new <<EOF
#         <Response stat="422" code="success">
#         <Error>Unknown VS</Error>
#         </Response>
# EOF

      if response.root.attributes["code"] == "fail"
          raise Puppet::ParseError, "Failed to delete virtual service '#{resource[:name]}', response code: #{response.root.attributes['stat']}"
      end
  end

  def webrequest(url, username, password)
      puts url
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
