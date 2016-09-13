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
    notify  => Exec[ "update-repositories" ],
    path    => [ "/bin", "/usr/bin", "/usr/local/bin" ],
  } ->

  exec { "update-repositories":
    command     => "sudo apt-get update",
    subscribe   => Exec[ "add-php7-repository" ],
    refreshonly => true,
    path        => [ "/bin", "/usr/bin", "/usr/local/bin" ],
  }

}
