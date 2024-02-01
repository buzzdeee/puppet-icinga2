# == Defined type: icinga2::object::host
#
#  This is a defined type for Icinga 2 host objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-host
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::host (
  String	$object_hostname         = $name,
  String	$display_name            = $fqdn,
  String	$ipv4_address            = $ipaddress,
  $ipv6_address            = undef,
  Boolean	$is_template             = false,
  Array		$templates               = ['generic-host'],
  Array		$groups                  = [],
  $vars                    = {},
  $check_command           = undef,
  $max_check_attempts      = undef,
  $check_period            = undef,
  $check_interval          = undef,
  $retry_interval          = undef,
  $enable_notifications    = true,
  $enable_active_checks    = undef,
  $enable_passive_checks   = undef,
  $enable_event_handler    = undef,
  $enable_flapping         = undef,
  $enable_perfdata         = undef,
  $event_command           = undef,
  #flapping_threshold is defined as a percentage, eg. 10%, 50%, etc.
  $flapping_threshold      = undef,
  $volatile                = undef,
  $notes                   = undef,
  $notes_url               = undef,
  $action_url              = undef,
  $icon_image              = undef,
  $icon_image_alt          = undef,
  String	$target_dir              = '/etc/icinga2/objects/hosts',
  String	$target_file_name        = "${name}.conf",
  $target_file_ensure      = file,
  String	$target_file_owner       = $::icinga2::config_owner,
  String	$target_file_group       = $::icinga2::config_group,
  String	$target_file_mode        = $::icinga2::config_mode,
  Boolean	$refresh_icinga2_service = true,
  Optional[String]	$zone                    = undef,
  Optional[String] 	$command_endpoint        = undef,
  Array		$custom_prepend          = [],
  Array		$custom_append           = [],
) {

  #If the refresh_icinga2_service parameter is set to true...
  if $refresh_icinga2_service == true {

    file { "${target_dir}/${target_file_name}":
      ensure  => $target_file_ensure,
      owner   => $target_file_owner,
      group   => $target_file_group,
      mode    => $target_file_mode,
      content => template('icinga2/object/host.conf.erb'),
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
      content => template('icinga2/object/host.conf.erb'),
    }

  }

}
