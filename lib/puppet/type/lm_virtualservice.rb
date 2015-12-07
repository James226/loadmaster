Puppet::Type.newtype(:lm_virtualservice) do
    ensurable

    newparam(:name)

    newparam(:host_ip)
    newparam(:host_username)
    newparam(:host_password)

    newparam(:ip)
    newparam(:port)
    newparam(:protocol)
end
