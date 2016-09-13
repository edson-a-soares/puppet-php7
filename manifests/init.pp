class php7 {

  exec { "adding-additional-tools":
      command => "sudo apt-get install --yes software-properties-common",
      onlyif  => "test ! -f /usr/bin/add-apt-repository",
      path    => [ "/bin", "/usr/bin", "/usr/local/bin" ],
  } ->

  exec { "add-language-pack":
    command => "sudo apt-get install --yes language-pack-en-base",
    onlyif  => "test ! -d /usr/share/locale-langpack/en",
    path    => [ "/bin", "/usr/bin", "/usr/local/bin" ],
  } ->

  exec { "add-php7-repository":
    command => "sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php",
    onlyif  => "test ! -f /etc/apt/sources.list.d/ondrej-php-trusty.list",
    notify  => Exec[ "apt-key-repository", "apt-update" ],
    path    => [ "/bin", "/usr/bin", "/usr/local/bin" ],
  } ->

  exec { "apt-key-repository":
    command     => "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C",
    subscribe   => Exec[ "add-php7-repository" ],
    refreshonly => true,
    path        => [ "/bin", "/usr/bin", "/usr/local/bin" ],
  }

  exec { "apt-update":
    command     => "sudo apt-get update",
    require     => Exec[ "apt-key-repository" ],
    subscribe   => Exec[ "add-php7-repository" ],
    refreshonly => true,
    path        => [ "/bin", "/usr/bin", "/usr/local/bin" ],
  }

}
