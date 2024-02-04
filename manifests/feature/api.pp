# == Class: icinga2::feature::api
#
# Manage and enable the internal API connections between Icinga daemons
#
# By default this features managed the certificate data as well and uses
# the Puppet agent's certificates.
#
class icinga2::feature::api (
  Boolean 	$accept_commands = false,
  Boolean	$accept_config   = false,
  $ca_path         = '/etc/icinga2/pki/ca.crt',
  $cert_path       = "/etc/icinga2/pki/${facts['networking']['fqdn']}.crt",
  $key_path        = "/etc/icinga2/pki/${facts['networking']['fqdn']}.key",
  $crl_path        = undef,
  $bind_host       = undef,
  $bind_port       = undef,
  Optional[Boolean]	$ticket_salt     = false,
  $hostname        = $facts['networking']['fqdn'],
  Boolean	$manage_zone     = true,
  $parent_zone     = undef,
) {

  ::icinga2::feature { 'api':
    content => template('icinga2/feature/api.conf.erb'),
  }

  if $manage_zone {
    $endpoints = {
      "${hostname}" => {},
    }
    ::icinga2::object::zone { $hostname:
      parent    => $parent_zone,
      endpoints => $endpoints,
    }

  }

}
