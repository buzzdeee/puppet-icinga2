# == Class: icinga2::feature::command
#
# Manage and enable the default log of Icinga2
#
class icinga2::feature::command (
  $command_path = undef,
) {

  ::icinga2::feature { 'command':
    content => template('icinga2/feature/command.conf.erb'),
  }
}
