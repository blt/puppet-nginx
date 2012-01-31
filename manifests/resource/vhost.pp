# This definition creates a new vhost entry for Nginx.
#
# See: http://wiki.nginx.org/HttpCoreModule#server
#
# It is assumed, anyway, that you'll be putting vhosts into this define. All
# files will be installed to /etc/nginx/sites-enabled/${name} and non-vhost
# definitions won't be of much use, there.
#
# Parameters:
#
#   [*ensure*]  - Enables or disables the vhost (present|absent)
#   [*content*] - Sets the content for the specified vhost
#
define nginx::resource::vhost($ensure = file, $content) {
  file { "${nginx::params::nx_conf_dir}/sites-enabled/${name}":
    ensure => $ensure,
    content => $content,
    notify => Class['nginx::service'],
  }
}
