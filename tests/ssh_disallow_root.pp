# test allow root is set to false
class { 
 'systeminit::ssh':
   'allow_root' => false;
}
