# Class: puppet-pbis
#
# This module manages puppet-pbis
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class puppet-pbis (
  $domaintojoin = $puppet-pbis::params::domaintojoin,
  $ldapbindaccount = $puppet-pbis::params::ldapbindaccount,
  $ldapbindpassword = $puppet-pbis::params::ldapbindpassword,
  $sudogroup = $puppet-pbis::params::sudogroup,
  $logingroup = $puppet-pbis::params::logingroup,
) inherits puppet-pbis::params {

}
