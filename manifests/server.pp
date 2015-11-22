# Class: ganglia::server
#
# This class installs the ganglia server
#
# Parameters:
#
# Actions:
#   installs the ganglia server
#
# Sample Usage:
#   include ganglia::server
#
class ganglia::server (
  $cluster        = $ganglia::params::cluster,
  $grid           = $ganglia::params::grid,
  $package_ensure = $ganglia::params::package_ensure,
  $data_source    = 'localhost',
  $data_sources   = undef,
  $trusted_hosts  = 'localhost',
) inherits ganglia::params {
  if $grid == '' {
    $gridname = $cluster
  } else {
    $gridname = $grid
  }

  package { 'ganglia-gmetad':
    ensure   => $package_ensure,
    notify   => Service['gmetad'],
  }
  file { '/etc/ganglia/gmetad.conf':
    ensure   => present,
    owner    => root,
    group    => root,
    mode     => '0644',
    content  => template('ganglia/gmetad.conf.erb'),
    require  => Package['ganglia-gmetad'],
    notify   => Service['gmetad'],
  }
  service {'gmetad':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => File['/etc/ganglia/gmetad.conf'],
  }
}

