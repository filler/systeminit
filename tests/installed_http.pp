# installed service
class { 
 'systeminit::http':
   'http_installed' => 'present',
   'http_service' => 'running',
   'http_onboot' => true;
}
