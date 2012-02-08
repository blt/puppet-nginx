# Static parameters for nginx. Look to config.pp and nginx.conf.erb for use.
#
# I'm not entirely pleased with this setup: a user will have to fork this
# repository to modify params for their environment. Making installation and
# bootstrapping of the server into a parameterized class could be a find
# alternative, without much interruption to the plonk-it-down and go crowd (me).

class nginx::params {
  $nx_temp_dir = '/tmp'
  $nx_run_dir  = '/var/nginx'

  $nx_conf_dir           = '/etc/nginx'
  $nx_worker_processes   = 4
  $nx_worker_connections = 1024
  $nx_multi_accept       = off
  $nx_sendfile           = on
  $nx_keepalive_timeout  = 65
  $nx_tcp_nodelay        = on
  $nx_tcp_nopush         = on
  $nx_gzip               = on
  $nx_always_https       = off

  $nx_client_body_temp_path   = "${nx_run_dir}/client_body_temp"
  $nx_client_body_buffer_size = '128k'
  $nx_client_max_body_size    = '10m'

  $nx_logdir = $kernel ? {
    /(?i-mx:linux)/ => '/var/log/nginx',
  }

  $nx_pid = $kernel ? {
    /(?i-mx:linux)/  => '/var/run/nginx.pid',
  }

  $nx_daemon_user = $operatingsystem ? {
    /(?i-mx:debian|ubuntu)/                    => 'www-data',
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => 'nginx',
  }
}
