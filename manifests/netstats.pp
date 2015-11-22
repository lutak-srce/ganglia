# Class: ganglia::netstats
#
# This class installs additional ganglia netstats module
class ganglia::netstats inherits ganglia::params {
  package { 'ganglia-gmond-modules-python':
    ensure   => present,
  }
  file { '/etc/ganglia/conf.d/netstats.pyconf':
    ensure   => present,
    owner    => root,
    group    => root,
    mode     => '0644',
    source   => 'puppet:///modules/ganglia/netstats.pyconf',
    require  => Package['ganglia-gmond-modules-python'],
    notify   => Service['gmond'],
  }
}
