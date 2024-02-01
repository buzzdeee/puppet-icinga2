# == Defined type: icinga2::object::notification
#
# This is a defined type for Icinga 2 apply objects that create notification commands
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-notification
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::notification (
  String		$object_notificationname = $name,
  Boolean	$is_template             = false,
  Array		$templates               = [],
  Optional[String]	$command                 = undef,
  Optional[String]	$host_name               = undef,
  Optional[String]	$service_name            = undef,
  $vars                    = {},
  Array		$users                   = [],
  Array		$user_groups             = [],
  $times                   = {},
  $interval                = undef,
  Optional[String]	$period                  = undef,
  Array		$types                   = [],
  Array		$states                  = [],
  String		$target_dir              = '/etc/icinga2/objects/notifications',
  String		$target_file_name        = "${name}.conf",
  $target_file_ensure      = file,
  String		$target_file_owner       = $::icinga2::config_owner,
  String		$target_file_group       = $::icinga2::config_group,
  String		$target_file_mode        = $::icinga2::config_mode,
  Boolean	$refresh_icinga2_service = true
) {

  #Array concatenation not available,
  #if $types - ['DowntimeStart','DowntimeEnd','DowntimeRemoved','Custom','Acknowledgement','Problem','Recovery','FlappingStart','FlappingEnd'] != [] {
  #  fail ('You are using unavailable notification type filter.')
  #}
  #Array concatenation not available,
  #if $states - ['OK','Warning','Critical','Unknown','Up','Down'] != [] {
  #  fail ('You are using unavailable state type filter.')
  #}

  #If the refresh_icinga2_service parameter is set to true...
  if $refresh_icinga2_service == true {

    file { "${target_dir}/${target_file_name}":
      ensure  => $target_file_ensure,
      owner   => $target_file_owner,
      group   => $target_file_group,
      mode    => $target_file_mode,
      content => template('icinga2/object/notification.conf.erb'),
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
      content => template('icinga2/object/notification.conf.erb'),
    }

  }

}
