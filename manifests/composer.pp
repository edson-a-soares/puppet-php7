define php7::composer ($directory = $title, $home_user, $filename = 'composer.phar', $group = 'root') {

  Class[ "php7::install" ] -> PHP7::Composer[$title]

  exec { "composer-downloading":
      command => "php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\"",
      cwd     => "/home/$home_user",
      onlyif  => "test ! -f /home/$home_user/composer-setup.php",
      path    => [ "/bin", "/usr/local/bin", "/usr/bin" ],
      notify  => Exec[ "composer-checking" ],
  } ->

  exec { "composer-checking":
      command     => "php -r \"if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;\"",
      cwd         => "/home/$home_user",
      path        => [ "/bin", "/usr/local/bin", "/usr/bin" ],
      subscribe   => Exec[ "composer-downloading" ],
      refreshonly => true,
  } ->

  exec { "composer-setup":
      command     => "php composer-setup.php --install-dir=$directory --filename=$filename",
      onlyif      => "test ! -f $directory/$filename",
      cwd         => "/home/$home_user",
      group       => $group,
      user        => root,
      environment => [ "HOME=/home/$home_user COMPOSER_HOME=/home/$home_user" ],
      path        => [ "/bin", "/usr/local/bin", "/usr/bin" ],
  } ->

  exec { "composer-unlink":
      command     => "php -r \"unlink('composer-setup.php');\"",
      cwd         => "/home/$home_user",
      subscribe   => Exec[ "composer-downloading" ],
      refreshonly => true,
      path        => [ "/bin", "/usr/local/bin", "/usr/bin" ],
  } ->

  exec { "composer-self-update":
    command     => "$directory/$filename self-update",
    environment => [ "HOME=/home/$home_user COMPOSER_HOME=/home/$home_user" ],
    path        => [ "/bin", "/usr/local/bin", "/usr/bin" ],
  }

}
