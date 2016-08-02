class puppet-pbis::install inherits puppet-pbis {
  include apt
 
  apt::source { 'powerbroker':
    comment  => 'Powerbroker Identity Services',
    location => 'http://repo.pbis.beyondtrust.com/apt',
    release  => 'pbiso',
    repos    => 'main',
    pin      => '500',
    key      => {
      'source'     => 'http://repo.pbis.beyondtrust.com/yum/RPM-GPG-KEY-pbis',
      'id'         => 'BE7FF72A6B7C8A9FAE061F4F2E52CD89C9CEECEF',
    },
    include  => {
      'deb' => true,
    },
  }

  exec { 'pbis-apt-get-update':
    command => '/usr/bin/apt-get update',
    refreshonly => true,
    require => Apt::Source['powerbroker'],
  }

  package { 'pbis-open' :
    ensure => installed,
    provider => apt,
    require => Exec['pbis-apt-get-update'],
  }

  $joindomain = "#!/bin/bash
    domainjoin-cli join $domaintojoin \$1 \$2
    cd /opt/pbis/bin/
    ./config UserDomainPrefix $domaintojoin
    ./config AssumeDefaultDomain true
    ./config LoginShellTemplate /bin/bash
    ./config HomeDirTemplate %H/%U
    ./config RequireMembershipOf '$domaintojoin\\$logingroup'
    "

  file { '/usr/local/bin/join-domain.sh' :
    ensure => present,
    owner => root,
    group => root,
    mode => '0544',
    content => "$joindomain"
  }
  
}
