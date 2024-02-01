# == Class: icinga2::feature::debuglog
#
# Manage and enable the debug log of Icinga2
#
class icinga2::feature::debuglog (
  $severity = 'debug',
  Stdlib::Compat::String	$path     = '/var/log/icinga2/debug.log'
) {

  validate_string($severity)

  ::icinga2::feature { 'debuglog':
    content => template('icinga2/feature/debuglog.conf.erb'),
  }
}
