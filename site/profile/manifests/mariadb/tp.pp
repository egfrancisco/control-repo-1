# This class manages the installation and initialisation of mariadb
#
# @param ensure If to install or remove mariadb
# @param template The path to the erb template (as used in template()) to use
#                 to populate the Runner configuration file. Note that if you
#                 use the runners parameter this file is automatically generated
#                 during runners registration
# @param options An open hash of options you may use in your template
#
class profile::mariadb::tp (
  String                $ensure      = 'present',
  Optional[String]      $template    = undef,
  Optional[String]      $content     = undef,
  Optional[String]      $epp         = undef,
  Hash                  $options     = { },
) {

  $options_default = {
  }
  $real_options = $options_default + $options
  ::tp::install { 'mariadb' :
    ensure             => $ensure,
    auto_prerequisites => $auto_prerequisites,
  }

  if $template {
    ::tp::conf { 'mariadb':
      ensure       => $ensure,
      template     => $template,
      content      => $content,
      epp          => $epp,
      base_dir     => 'conf',
      options_hash => $real_options,
    }
  }

}
