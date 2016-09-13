define php7::phpinfo ($directory = $title, $file = 'info', $group = 'www-data', $owner = 'root') {

  Class[ "php7::install" ] -> PHP7::Phpinfo[$title]

  file { "$directory/$file.php":
    ensure	  => file,
    source	  => "puppet:///modules/php7/info.php",
    group	    => $group,
    owner	    => $owner,
  }

}
