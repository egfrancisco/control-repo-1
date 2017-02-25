# This class manages the installation and initialisation of icingaweb2
#
# @param ensure If to install or remove icingaweb2
# @param auto_prerequisites If to automatically install all the prerequisites
#                           resources needed to install the runner
# @param template The path to the erb template (as used in template()) to use
#                 to populate the Runner configuration file. Note that if you
#                 use the runners parameter this file is automatically generated
#                 during runners registration
# @param options An open hash of options you may use in your template
#
class profile::icingaweb2 (
  String                $ensure      = 'present',
  Optional[String]      $webserver_class = '::profile::apache::tp',
  Optional[String]      $dbserver_class  = '::profile::mariadb::tp',
  Boolean               $auto_prerequisites = true,
  Optional[String]      $template    = undef,
  Hash                  $options     = { },
  Optional[Enum['mysql','pgsql']] $db_backend = 'mysql',
) {

  if $webserver_class and $webserver_class != '' {
    contain $webserver_class
  }
  if $dbserver_class and $dbserver_class != '' {
    contain $dbserver_class
  }

  $options_default = {
  }
  $real_options = $options_default + $options
  ::tp::install { 'icingaweb2' :
    ensure             => $ensure,
    auto_prerequisites => $auto_prerequisites,
  }

  if $template {
    ::tp::conf { 'icingaweb2':
      ensure       => $ensure,
      template     => $template,
      base_dir     => 'conf',
      options_hash => $real_options,
    }
  }

  if $db_backend {
    package { "icinga2-ido-${db_backend}": }
  }

}
