define php7::composer ($directory = $title, $home_user, $filename = 'composer.phar', $group = 'root') {

  Class[ "php7::install" ] -> PHP7::Composer[$title]

  $composer_file_name = "composer-setup.php"

  file { "/home/$home_user/composer-checking-script.sh":
    source  => "puppet:///modules/php7/composer/composer-checking-script.sh",
    ensure  => present,
    owner   => $home_user,
    group   => $group,
    mode    => "+x",
  } ->

  exec { "composer-downloading":
    command => "sudo wget https://getcomposer.org/installer -O /home/$home_user/$composer_file_name",
    onlyif  => "test ! -f $directory/$filename",
    path    => [ "/bin", "/usr/local/bin", "/usr/bin" ],
    notify  => Exec[ "composer-checking" ],
  } ->

  exec { "composer-checking":
    command     => "sudo bash /home/$home_user/composer-checking-script.sh /home/$home_user $composer_file_name",
    provider    => shell,
    timeout     => 2500,
    user        => $home_user,
    environment => [ "HOME=/home/$home_user" ],
    path        => [ "/usr/bin", "/bin" ],
    require     => [ Exec["composer-downloading"], File["/home/$home_user/composer-checking-script.sh"] ],
    subscribe   => Exec["composer-downloading"],
    refreshonly => true,
  } ->

  exec { "composer-setup":
    command     => "php /home/$home_user/$composer_file_name --install-dir=$directory --filename=$filename",
    onlyif      => "test ! -f $directory/$filename",
    group       => $group,
    user        => root,
    notify      => Exec[ "composer-self-update" ],
    environment => [ "HOME=/home/$home_user COMPOSER_HOME=/home/$home_user" ],
    path        => [ "/bin", "/usr/local/bin", "/usr/bin" ],
  } ->

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
