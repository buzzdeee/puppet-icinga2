# == Defined type: icinga2::object::apply_notification_to_service
#
#  This is a defined type for Icinga 2 apply dependency objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-notification
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#apply
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::apply_notification_to_service (
  $object_notificationname = $name,
  $host_name               = undef,
  Array		$templates               = [],
  $assign_where            = undef,
  $ignore_where            = undef,
  $command                 = undef,
  $vars                    = {},
  Array		$users                   = [],
  Array		$user_groups             = [],
  $times                   = {},
  $interval                = undef,
  $period                  = undef,
  Array		$types                   = [],
  Array		$states                  = [],
  $target_dir              = '/etc/icinga2/objects/applys',
  $target_file_name        = "${name}.conf",
  $target_file_ensure      = file,
  $target_file_owner       = $::icinga2::config_owner,
  $target_file_group       = $::icinga2::config_group,
  $target_file_mode        = $::icinga2::config_mode,
  Boolean $refresh_icinga2_service = true
) {

  #If the refresh_icinga2_service parameter is set to true...
  if $refresh_icinga2_service == true {

    file { "${target_dir}/${target_file_name}":
      ensure  => $target_file_ensure,
      owner   => $target_file_owner,
      group   => $target_file_group,
      mode    => $target_file_mode,
      content => template('icinga2/object/apply_notification_to_service.conf.erb'),
      #...notify the Icinga 2 daemon so it can restart and pick up changes made to this config file...
      notify  => Class['::icinga2::service'],
    }

  }
  #...otherwise, use the same file resource but without a notify => parameter:
  else {

    file { "${target_dir}/${target_file_name}":
      ensure  => $target_file_ensure,
      owner   => $target_file_owner,
      group   => $target_file_group,
      mode    => $target_file_mode,
      content => template('icinga2/object/apply_notification_to_service.conf.erb'),
    }

  }

}
