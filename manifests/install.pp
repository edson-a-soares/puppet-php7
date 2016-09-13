class php7::install {

  include php7

  package { "php7.0":
    ensure  => installed,
    require => Class[ "php7" ]
  }

}
