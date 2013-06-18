# == Defined type: systeminit::ssh::sshd_config_option
#
# This is a defined type to manage sshd config options via augeas
#
# === Parameters
#
# [*name*]
#   Weither or not to allow root login via ssh
#   Valid values: <code>true</code> or <code>false</code>.
#   Default: false
#
# [*value*]
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
