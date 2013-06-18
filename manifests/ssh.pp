# == Class: systeminit::ssh
#
# This class installs and configures ssh for CentOS, RedHat, Fedora, Ubunto and Debian
# distributions.
#
# === Parameters
#
# [*allow_root*]
#   Weither or not to allow root login via ssh
#   Valid values: <code>true</code> or <code>false</code>.
#   Default: false
#
# === Requires
#
# None
#
# === Examples
#
# node 'localhost' {
#  class {
#   "systeminit::ssh": allow_root => true ;
#  }
# }
#
# === Authors
#
# - Alex Schultz <aschultz@next-development.com>
#

class systeminit::ssh (
   $allow_root = false,
  ) {
  # set our packagename, service name and sshd configuration
  # file based on the operating system
  $package_name = "openssh-server"
  $sshd_configuration_file = "/etc/ssh/sshd_config"
  case $::operatingsystem {
    CentOS, RedHat, Fedora: {
       $service_name = "sshd"
    }
    Debian, Ubuntu: {
       $service_name = "ssh"
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

  # the sshd package
  package {
   $package_name:
    name => $package_name,
    ensure => "present",
  }

  # the sshd service
  service {
   $service_name:
    ensure => running,
    enable => true,
    require => Package[$package_name],
    subscribe => File[$sshd_configuration_file]
  }

  # the sshd configuration file
  file {
     $sshd_configuration_file:
       require => Package[$package_name],
       notify => Service[$service_name],
       ensure => present,
  }
 
  # set the PermitRootLogin option
  systeminit::ssh::sshd_config_option {
    "PermitRootLogin": 
     value => $allow_root ? {
        true => "yes",
        false => "no",
        default => "no",
    }
  }
}
