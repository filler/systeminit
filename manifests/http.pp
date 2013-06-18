# == Class: systeminit::http
#
# This class installs and configures apache for CentOS, RedHat, Fedora, Ubunto and Debian
# distributions.
#
# === Parameters
#
# [*shttp_installed*]
#   Weither or not the apache should be installed
#   Valid values: <code>present</code> or <code>absent</code>.
#   Default: present
#
# [*http_service*]
#   Weither or not the apache service should be running
#   Valid values: <code>running</code> or <code>stopped</code>.
#   Default: running
#
# [*http_onboot*]
#   Weither or not the apache service should be started on boot
#   Valid values: <code>true</code> or <code>false</code>.
#   Default: true
#
# === Requires
#
# None
#
# === Examples
#
# node 'localhost' {
#  class {
#   "systeminit::http": ;
#  }
# }
#
# === Authors
#
# - Alex Schultz <aschultz@next-development.com>
#

class systeminit::http(
   $http_installed = "present",
   $http_service = "running",
   $http_onboot = "true",
  ) {
  # set our packagename, service name, service status ability and httpd configuration
  # file based on the operating system
  case $::operatingsystem {
    CentOS, RedHat, Fedora: {
       $package_name = "httpd"
       $service_name = "httpd"
       $service_status = true
       $http_configuration_file = "/etc/httpd/conf/httpd.conf"
    }
    Debian, Ubuntu: {
       $package_name = "apache2"
       $service_name = "apache2"
       $service_status = false
       $http_configuration_file = "/etc/apache2/apache2.conf"
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

  # the apache httpd package
  package {
   $package_name:
    name => $package_name,
    ensure => $http_installed,
  }

  # the apache httpd service
  service {
   $service_name:
    ensure => $http_service,
    enable => $http_onboot,
    hasrestart => true,
    require => Package[$package_name],
    subscribe => File[$http_configuration_file]
  }

  # the apache httpd configuration file
  file {
     $http_configuration_file:
       require => Package[$package_name],
       notify => Service[$service_name],
       ensure => $http_installed,
  }
}
