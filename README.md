systeminit
==========

systeminit puppet module

This is a puppet module to manage the installation and startup of Apache httpd and update the ssh server to allow or disallow root logins.

Example Usage:

    class {
     'systeminit::http':
       'http_installed' => 'present',
       'http_service' => 'running',
       'http_onboot' => true;
     'systeminit::ssh':
       'allow_root' => false;
    }

