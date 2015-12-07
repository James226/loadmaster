Puppet::Type.newtype(:lm_realserver) do
    ensurable

    newparam(:name)

    newparam(:host_ip)
    newparam(:host_username)
    newparam(:host_password)

    newparam(:virtual_ip)
    newparam(:virtual_port)
    newparam(:virtual_protocol)

    newparam(:ip)
    newparam(:port)
end
