# Class: ganglia::webserver
#
# This class installs the ganglia web server
#
# Parameters:
#
# Actions:
#   installs the ganglia web server
#
# Sample Usage:
#   include ganglia::server
#
class ganglia::webserver {
  package { 'ganglia-web':
    ensure => present,
  }
  file { '/var/www/html/ganglia/robots.txt':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => 'puppet:///modules/ganglia/robots.txt',
    require => Package['ganglia-web'],
  }
}
