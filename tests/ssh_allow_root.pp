# test allow root is set to true
class { 
 'systeminit::ssh':
   'allow_root' => true;
}
