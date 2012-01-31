class nginx {
  include nginx::package, nginx::config, nginx::service
}
