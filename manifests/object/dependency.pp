# == Defined type: icinga2::object::dependency
#
#  This is a defined type for Icinga 2 dependency objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-dependency
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::dependency (
  String	$object_name             = $name,
  String	$display_name            = $name,
  String	$parent_host_name        = $host_name,
  Optional[String]	$parent_service_name     = undef,
  Optional[String]	$child_host_name         = undef,
  Optional[String]	$child_service_name      = undef,
  Optional[Boolean]	$disable_checks          = undef,
  Optional[Boolean]	$disable_notifications   = undef,
  Optional[String]	$period                  = undef,
  Array		$states                  = [],
  String	$target_dir              = '/etc/icinga2/objects/dependencies',
  String	$target_file_name        = "${name}.conf",
  $target_file_ensure      = file,
  String	$target_file_owner       = $::icinga2::config_owner,
  String	$target_file_group       = $::icinga2::config_group,
  String	$target_file_mode        = $::icinga2::config_mode,
  Boolean	$refresh_icinga2_service = true
) {

  #If the refresh_icinga2_service parameter is set to true...
  if $refresh_icinga2_service == true {

    file { "${target_dir}/${target_file_name}":
      ensure  => $target_file_ensure,
      owner   => $target_file_owner,
      group   => $target_file_group,
      mode    => $target_file_mode,
      content => template('icinga2/object/dependency.conf.erb'),
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
      content => template('icinga2/object/dependency.conf.erb'),
    }

  }

}
