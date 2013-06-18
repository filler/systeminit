# == Defined type: systeminit::ssh::sshd_config_option
#
# This is a defined type to manage sshd config options via augeas
#
# === Parameters
#
# [*name*]
#  This is the name of the configuration value that you would like to change   
#
# [*value*]
#  This is the value of the configuration item that you would like to change
#
# === Requires
#
# None
#
# === Examples
#
# systeminit::ssh::sshd_config_option {
#  "PermitRootLogin": "yes"
# }
#
# === Authors
#
# - Alex Schultz <aschultz@next-development.com>
#

define systeminit::ssh::sshd_config_option ($value) {
  augeas {
    "sshd_config_$name":
       context => "/files/etc/ssh/sshd_config",
       changes => "set $name $value",
       onlyif => "get $name != $value",
  }
}
