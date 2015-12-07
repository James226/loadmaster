Puppet::Type.newtype(:loadmaster) do
  ensurable

  newparam(:name)

  newproperty(:test)
end
