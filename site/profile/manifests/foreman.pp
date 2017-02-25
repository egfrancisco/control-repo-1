# This class manages the installation and initialisation of foreman
#
# @param ensure If to install or remove foreman
# @param template The path to the erb template (as used in template()) to use
#                 to populate the Runner configuration file. Note that if you
#                 use the runners parameter this file is automatically generated
#                 during runners registration
# @param options An open hash of options you may use in your template
#
class profile::foreman (
  Optional[String] $install_class = 'profile::foreman::tp',
) {

  if $install_class { contain $install_class }

}
