# standard test to test http is not installed 
class { 
 'systeminit::http':
   'http_installed' => 'absent',
   'http_service' => 'stopped',
   'http_onboot' => false;
}
