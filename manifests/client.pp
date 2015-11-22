# Class: ganglia::client
#
# This class installs the ganglia client
#
# Parameters:
#   $cluster
#     default unspecified
#     this is the name of the cluster
#
#   $udp_port
#     default 8649
#     this is the udp port to multicast metrics on
#
# Actions:
#   installs the ganglia client
#
# Sample Usage:
#   include ganglia::client
#
#   or
#
#   class {'ganglia::client': cluster => 'mycluster' }
#
#   or
#
#   class {'ganglia::client':
#     cluster  => 'mycluster',
#     udp_port => '1234';
#   }
#
class ganglia::client (
  $cluster                = $ganglia::params::cluster,
  $owner                  = $ganglia::params::owner,
  $udp_port               = $ganglia::params::udp_port,
  $tcp_port               = $ganglia::params::tcp_port,
  $udp_mcast_join         = $ganglia::params::udp_mcast_join,
  $udp_bind               = $ganglia::params::udp_bind,
  $udp_host               = $ganglia::params::udp_host,
  $unicast                = $ganglia::params::unicast,
  $mute                   = $ganglia::params::mute,
  $deaf                   = $ganglia::params::deaf,
  $send_metadata_interval = $ganglia::params::send_metadata_interval,
  $tcp_accept_channel     = $ganglia::params::tcp_accept_channel,
  $package_ensure         = $ganglia::params::package_ensure,
  $udphosts               = $ganglia::params::udphosts,
  $override_hostname      = $ganglia::params::override_hostname,
) inherits ganglia::params {
  package { 'ganglia-gmond':
    ensure   => $package_ensure,
    notify   => Service['gmond'],
  }
  file { '/etc/ganglia/gmond.conf':
    ensure   => present,
    owner    => root,
    group    => root,
    mode     => '0644',
    content  => template('ganglia/gmond.conf.erb'),
    require  => Package['ganglia-gmond'],
    notify   => Service['gmond'],
  }
  service {'gmond':
    ensure   => running,
    enable   => true,
    provider => redhat,
    require  => File['/etc/ganglia/gmond.conf'],
  }
}
