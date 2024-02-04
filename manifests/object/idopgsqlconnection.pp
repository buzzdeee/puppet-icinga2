# == Defined type: icinga2::object::idopgsqlconnection
#
# This is a defined type for Icinga 2 IDO Postgres connection objects.
#
define icinga2::object::idopgsqlconnection (
  String		$object_name          = $name,
  String		$host                 = 'localhost',
  $port                 = undef,
  String		$user                 = 'icinga',
  String		$password             = 'icinga',
  String		$database             = 'icinga',
  String		$table_prefix         = 'icinga_',
  String		$instance_name        = 'default',
  $instance_description = undef,
  Boolean	$enable_ha            = true,
  $cleanup              = {
    acknowledgements_age           => 0,
    commenthistory_age             => 0,
    contactnotifications_age       => 0,
    contactnotificationmethods_age => 0,
    downtimehistory_age            => 0,
    eventhandlers_age              => 0,
    externalcommands_age           => 0,
    flappinghistory_age            => 0,
    hostchecks_age                 => 0,
    logentries_age                 => 0,
    notifications_age              => 0,
    processevents_age              => 0,
    statehistory_age               => 0,
    servicechecks_age              => 0,
    systemcommands_age             => 0,
  },
  Array		$categories           = [],
  $target_file_name     = "${name}.conf",
  $target_dir           = '/etc/icinga2/objects/idopgsqlconnections',
  Boolean	$refresh_service      = $::icinga2::manage_service,
) {

  if ! defined(Class['icinga2']) {
    fail('You must include the icinga2 base class before using any icinga2 defined resources')
  }

  Class['icinga2::config'] ->
  file { "${target_dir}/${target_file_name}":
    ensure  => file,
    owner   => $::icinga2::config_owner,
    group   => $::icinga2::config_group,
    mode    => $::icinga2::config_mode,
    content => template('icinga2/object/idopgsqlconnection.conf.erb'),
  }

  if $refresh_service == true {
    File["${target_dir}/${target_file_name}"] ~> Class['::icinga2::service']
  }

}
