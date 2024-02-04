# == Class: icinga2::feature::debuglog
#
# Manage and enable the debug log of Icinga2
#
class icinga2::feature::debuglog (
  $severity = 'debug',
  $path     = '/var/log/icinga2/debug.log'
) {

  ::icinga2::feature { 'debuglog':
    content => template('icinga2/feature/debuglog.conf.erb'),
  }
}
