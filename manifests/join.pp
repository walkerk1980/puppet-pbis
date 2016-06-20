class puppet-pbis::join inherits puppet-pbis {
  
$sudofile="#
# This file MUST be edited with the visudo command as root.
#
# Please consider adding local content in /etc/sudoers.d/ instead of
# directly modifying this file.
#
# See the man page for details on how to write a sudoers file.
#
Defaults	env_reset
Defaults	mail_badpass
Defaults	secure_path=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\"

# Host alias specification

# User alias specification

# Cmnd alias specification

# User privilege specification
root	ALL=(ALL:ALL) ALL

# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL

# Allow members of group sudo to execute any command
%sudo	ALL=(ALL:ALL) ALL

#Domain Admins
%$domaintojoin\\\\$sudogroup	ALL=(ALL:ALL) ALL

# See sudoers(5) for more information on #include directives:

#includedir /etc/sudoers.d
"

  file { '/etc/sudoers' :
    ensure => present,
    owner => root,
    group => root,
    mode => '0440',
    content => "$sudofile"
  }

  exec { 'join':
    command => "/usr/local/bin/join-domain.sh $ldapbindaccount $ldapbindpassword",
    require => Class['puppet-pbis::install'],
    unless => "/bin/echo $(/usr/bin/domainjoin-cli query)|/bin/grep OPTIVLABS",
  }

  $resolvfile="nameserver 172.16.18.2
nameserver 172.16.18.4
search $domaintojoin
"

  file { '/etc/resolvconf/resolv.conf.d/base' :
    ensure => present,
    owner => root,
    group => root,
    mode => '0644',
    content => $resolvfile
  }


}
