class php7::install {

  include apt

  apt::ppa { 'ppa:ondrej/php': } ->

  package { "php7.0":
    ensure => installed
  }

}
