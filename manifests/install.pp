# == Class: icinga2::install
#
# This class installs the Icinga 2 daemon and needed packages.
#
class icinga2::install {

  package { 'icinga2':
    ensure   => $::icinga2::package_ensure,
  }

  if $::icinga2::manage_service == true {
    Package['icinga2'] ~> Class['::icinga2::service']
  }

  if $::icinga2::install_plugins == true {
    ensure_packages($::icinga2::plugin_packages)
  }
  if count($::icinga2::plugin_packages_extra) > 0 {
    ensure_packages($::icinga2::plugin_packages_extra)
  }

  if $::icinga2::install_mailutils == true {
    ensure_packages($::icinga2::params::mail_package)
  }

}
