# NGINX Module

Originally by James Fryman <jamison@puppetlabs.com>.

This module manages NGINX from within Puppet. It manages installation of OS
package, the running service and the placement of configuration files through
exposed resources. These resources do _not_ construct configuration files for
you--except those which are delightfully simple--requiring a provided template.

This might sound like a bummer, but mimicking nginx's complex configuration
language in puppet is a real horror show. Read on for a quick-start
tutorial. The source code is well documented and should be readable by those new
to puppet.

## Quick Start

Install puppet-nginx into your modules (do this from the root of your primary
puppet repository):

    $ git submodule add modules/nginx git://github.com/blt/puppet-nginx.git

If you're on Debian you will need to install `puppet-apt` as well.

    $ git submodule add modules/apt git://github.com/blt/puppet-apt.git

Include nginx to install and bootstrap it on a box:

<pre>
    node /^app\d+\.example\.com/ {
      include nginx

      # Setup the default vhost, with supplied template.
      nginx::resource::vhost { 'default':
        ensure  => present,
        content => template('app/vhost.erb'),
      }
      # Setup the upstream proxies referenced by the default vhost (pretend with
      # me here).
      nginx::resource::upstream { 'default':
        ensure => present,
        members =>
        [
          'unix:/var/run/puppet/master.00.sock',
          'unix:/var/run/puppet/master.01.sock',
          'unix:/var/run/puppet/master.02.sock',
        ]
      }
    }
</pre>

The only resources provided by this module are those used above. Find them in
`manifests/resources/`. Explore this module for more
details. If you find a place that might be better documented, it _should_ and do
take out an issue ticket.
