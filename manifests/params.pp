class puppet-pbis::params {
  $domaintojoin = 'example.com'
  $ldapbindaccount = 'user'
  $ldapbindpassword = 'password'
  $sudogroup = 'Domain^Admins'
  $logingroup = 'Domain^Users'
  $dns1 = '172.16.18.2'
  $dns2 = '172.16.18.4'
}
