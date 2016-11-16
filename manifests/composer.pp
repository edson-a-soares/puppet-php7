define php7::composer ($directory = $title, $home_user, $filename = 'composer.phar', $group = 'root', $hash_code) {

  Class[ "php7::install" ] -> PHP7::Composer[$title]

  $composer_file_name = "composer-setup.php"

  exec { "composer-downloading":
    command => "wget https://getcomposer.org/installer --directory-prefix=/home/$home_user -O $composer_file_name",
    onlyif  => "test ! -f $directory/$filename",
    path    => [ "/bin", "/usr/local/bin", "/usr/bin" ],
    notify  => Exec[ "composer-checking" ],
  }

  exec { "composer-checking":
    command     => "php -r \"if (hash_file('SHA384', '/home/$home_user/$composer_file_name') === '$hash_code') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('/home/$home_user/$composer_file_name'); } echo PHP_EOL;\"",
    path        => [ "/bin", "/usr/local/bin", "/usr/bin" ],
    subscribe   => Exec[ "composer-downloading" ],
    refreshonly => true,
  }

  exec { "composer-setup":
    command     => "php /home/$home_user/$composer_file_name --install-dir=$directory --filename=$filename",
    onlyif      => "test ! -f $directory/$filename",
    group       => $group,
    user        => root,
    notify      => Exec[ "composer-self-update" ],
    environment => [ "HOME=/home/$home_user COMPOSER_HOME=/home/$home_user" ],
    path        => [ "/bin", "/usr/local/bin", "/usr/bin" ],
  }

  exec { "composer-unlink":
    command     => "php -r \"unlink('/home/$home_user/$composer_file_name');\"",
    subscribe   => Exec[ "composer-downloading" ],
    refreshonly => true,
    path        => [ "/bin", "/usr/local/bin", "/usr/bin" ],
  } ->

  exec { "composer-self-update":
    command     => "$directory/$filename self-update",
    environment => [ "HOME=/home/$home_user COMPOSER_HOME=/home/$home_user" ],
    subscribe   => Exec[ "composer-setup" ],
    refreshonly => true,
    path        => [ "/bin", "$directory", "/usr/bin" ],
  }

}
