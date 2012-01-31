class nginx::service {

  # A standard puppet service
  # (http://docs.puppetlabs.com/references/stable/type.html#service) save that
  # I've overridden the restart command to perform a 'reload'. Puppet should
  # _not_ be able to take a webserver offline, especially not if a vhost
  # definition has been modified.
  #
  # There are some cases in which a full restart is required, but lacking the
  # ability to tag a notify with metadata really puts a hamper on separating the
  # restarts from the reload. Err, then, on the side of caution.

  service { "nginx":
    ensure    => running,
    enable    => true,
    hasstatus => true,
    restart   => '/etc/init.d/nginx reload',
    require   => Class['nginx::config'],
  }

}
