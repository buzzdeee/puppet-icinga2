# == Class: icinga2::feature::notification
#
# Manage and enable the NotificationComponent of Icinga2
#
class icinga2::feature::notification (
  Boolean	$enable_ha = true,
) {

  ::icinga2::feature { 'notification':
    content => template('icinga2/feature/notification.conf.erb'),
  }
}
