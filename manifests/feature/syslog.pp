# == Class: icinga2::feature::syslog
#
# Manage and enable syslog of Icinga2
#
class icinga2::feature::syslog (
  $severity = 'warning',
) {

  ::icinga2::feature { 'syslog':
    content => template('icinga2/feature/syslog.conf.erb'),
  }
}
