class php7::install {

  include apt

  apt::ppa { 'ppa:ondrej/php': } ->

  exec { "php7-installation":
    command	=> "sudo apt-get install --yes php7.0",
    path	=> [ "/usr/bin", "/bin" ],
  }

}
