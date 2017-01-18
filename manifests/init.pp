# Class: idrac_config
# ========================================
# ilo_config is a module to configure basic settings for the OOB-idrac interface.
# ========================================

class ilo_config (
$ensure       =   'present',
$hostname     =   $::hostname,
$iloname      =   "ilo-$::hostname",
$dhcp         =   'Y',
$staticip     =   $ilo_config::params::staticip,
$netmask      =   $ilo_config::params::netmask,
$gateway      =   $ilo_config::params::gateway,
$pridns       =   $ilo_config::params::pridns,
$scriptpath   =   $ilo_config::params::scriptpath,
) inherits ilo_config::params {
 if $::manufacturer == 'HP' and $ensure=='present' {
  file {"$scriptpath/ilo_inventory.sh":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    content => template('ilo_config/ilo_inventory.erb'),
  }
  file {"$scriptpath/ilo_delay.sh":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    content => template('ilo_config/ilo_delay.erb'),
  }
  cron { 'ilo-inventory':
    command => "$scriptpath/ilo_inventory.sh",
    user    => 'root',
    hour    => '6',
    minute  => '0',
  }
  package { 'hponcfg':
    ensure => 'installed',
  }
  if $dhcp != $::ilo_dhcp {
   if $dhcp == 'Y' {
    file {"$scriptpath/dhcp.xml":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0744',
      content => template('ilo_config/dhcp.erb'),
      before  => EXEC['set-dhcp']
    }
    exec {'set-dhcp':
      command => "/usr/bin/nohup hponcfg -f $scriptpath/dhcp.xml > /dev/null 2>&1 &",
      path    => '/sbin/',
      before  => EXEC['del-dhcp'],
    }
    exec {'del-dhcp':
      command => "$scriptpath/ilo_delay.sh 20s rm -rf $scriptpath/dhcp.xml",
    }
   }
   elsif $dhcp == 'N' {
    file {"$scriptpath/static.xml":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0744',
      content => template('ilo_config/static.erb'),
      before  => EXEC['set-static'],
   }
    exec {'set-static':
      command => "hponcfg -f $scriptpath/static.xml &>/dev/null &disown",
      path    => 'sbin',
      before  => EXEC['del-static'],
    }
    exec {'del-static':
      command => "$scriptpath/ilo_delay.sh 20s rm -rf $scriptpath/static.xml",
    }
   }
  }
 }
}
