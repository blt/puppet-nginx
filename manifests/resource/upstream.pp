# This definition creates a new upstream proxy entry for NGINX.
#
# See http://wiki.nginx.org/HttpUpstreamModule for more details.
#
# Parameters:
#
#   [*ensure*]  - Enables or disables the specified location (present|absent)
#   [*members*] - Array of member URIs for NGINX to connect to. Must follow valid NGINX syntax.
#
define nginx::resource::upstream ($ensure = present, $members ) {
  file { "${nginx::params::nx_conf_dir}/conf.d/${name}-upstream.conf":
    ensure   => $ensure,
    content  => template('nginx/conf.d/upstream.erb'),
    notify   => Class['nginx::service'],
  }
}
