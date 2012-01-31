class nginx::package {

  # There's probably a more DRY way to express this. If we're on Debian pin
  # nginx to come from squeeze-backports and install there. Requires
  # puppet-apt. See the project README for details.

  case $operatingsystem {
    'debian': {
      apt::preference { 'nginx':
        package => 'nginx nginx-common',
        priority => '600',
        release => 'a=squeeze-backports',
      }

      package { 'nginx':
        ensure => present,
        require => Apt::Preference['nginx'],
      }
    }
    default: {
      package { 'nginx':
        ensure => present,
      }
    }
  }

}
