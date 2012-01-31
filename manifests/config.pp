class nginx::config inherits nginx::params {
  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Class['nginx::package'],
  }

  file { "${nginx::params::nx_conf_dir}":
    ensure => directory,
  }

  file { "${nginx::params::nx_conf_dir}/conf.d":
    ensure => directory,
  }

  file { "${nginx::config::nx_run_dir}":
    ensure => directory,
  }

  file { "${nginx::config::nx_client_body_temp_path}":
    ensure => directory,
    owner  => $nginx::params::nx_daemon_user,
  }

  file { "${nginx::params::nx_conf_dir}/nginx.conf":
    ensure  => file,
    content => template('nginx/conf.d/nginx.conf.erb'),
  }

  file { "${nx_conf_dir}/fastcgi_params":
    ensure => present,
    source => "puppet:///modules/nginx/fastcgi_params",
    notify => Class['nginx::service'],
  }
}
