# == Defined type: icinga2::object::icingastatuswriter
#
# This is a defined type for Icinga 2 apply objects that create IcingaStatusWriter
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-checkercomponent
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::icingastatuswriter (
  $ensure                    = 'file',
  $object_name               = $name,
  Optional[String]	$status_path               = undef,
  Optional[String]	$update_interval           = undef,
  String		$target_dir                = '/etc/icinga2/objects/icingastatuswriters',
  String		$target_file_name          = "${name}.conf",
  String		$target_file_owner         = $::icinga2::config_owner,
  String		$target_file_group         = $::icinga2::config_group,
  String		$target_file_mode          = $::icinga2::config_mode,
) {

  file {"${target_dir}/${target_file_name}":
    ensure  => $ensure,
    owner   => $target_file_owner,
    group   => $target_file_group,
    mode    => $target_file_mode,
    content => template('icinga2/object/icingastatuswriter.conf.erb'),
    notify  => Class['::icinga2::service'],
  }
}
