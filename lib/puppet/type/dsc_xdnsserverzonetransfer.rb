# workaround for cross modules dependencies
master_path = File.expand_path(File.join(__FILE__, '..', '..', '..', '..', '..', 'dsc','lib'))
$:.push(master_path) if File.directory?(master_path)
require 'puppet/type/base_dsc'

Puppet::Type.newtype(:dsc_xdnsserverzonetransfer) do

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  provide :mof, :parent => Puppet::Type.type(:base_dsc).provider(:mof)

  @doc = %q{
    The DSC xDnsServerZoneTransfer resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/dsc-resource-kit/xDnsServer/DSCResources/MSFT_xDnsServerZoneTransfer/MSFT_xDnsServerZoneTransfer.schema.mof
  }

  validate do
      fail('dsc_name is a required attribute') if self[:dsc_name].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xDnsServerZoneTransfer"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xDnsServerZoneTransfer"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      value.to_s.downcase.to_bool
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xDnsServer"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.0"
  end

  newparam(:name, :namevar => true ) do
  end

  # Name:         Name
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_name) do
    desc "Name of the DNS zone"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Type
  # Type:         string
  # IsMandatory:  False
  # Values:       ["None", "Any", "Named", "Specific"]
  newparam(:dsc_type) do
    desc "Type of transfer allowed"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['None', 'none', 'Any', 'any', 'Named', 'named', 'Specific', 'specific'].include?(value)
        fail("Invalid value '#{value}'. Valid values are None, Any, Named, Specific")
      end
    end
  end

  # Name:         SecondaryServer
  # Type:         string[]
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_secondaryserver, :array_matching => :all) do
    desc "IP address or DNS name of DNS servers where zone information can be transfered"
    validate do |value|
      unless value.kind_of?(Array) || value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string or an array of strings")
      end
    end
  end


end
