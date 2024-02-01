# == Defined type: icinga2::object::servicegroup
#
# This is a defined type for Icinga 2 servicegroup objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-servicegroup
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::servicegroup (
  String		$object_servicegroup_name = $name,
  String		$display_name             = $name,
  Array		$templates                = [],
  Array		$groups                   = [],
  String		$target_dir               = '/etc/icinga2/objects/servicegroups',
  String		$target_file_name         = "${name}.conf",
  $target_file_ensure       = file,
  String		$target_file_owner        = $::icinga2::config_owner,
  String		$target_file_group        = $::icinga2::config_group,
  String		$target_file_mode         = $::icinga2::config_mode,
  $assign_where             = undef,
  $ignore_where             = undef,
  Boolean	$refresh_icinga2_service  = true
) {

  #If the refresh_icinga2_service parameter is set to true...
  if $refresh_icinga2_service == true {

    file { "${target_dir}/${target_file_name}":
      ensure  => $target_file_ensure,
      owner   => $target_file_owner,
      group   => $target_file_group,
      mode    => $target_file_mode,
      content => template('icinga2/object/servicegroup.conf.erb'),
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
      content => template('icinga2/object/servicegroup.conf.erb'),
    }

  }

}
