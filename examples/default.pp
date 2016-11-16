# Install PHP7 and some packages
include php7::install

# Install PHP7 Packages
php7::package { "php7.0-fpm": } ->
php7::package { "php7.0-mysql": } ->
php7::package { "php7.0-curl php7.0-mcrypt": }

# Add PHPInfo file
php7::phpinfo { "/var/www/html": }

# Install Composer
php7::composer { "/usr/local/bin":
  home_user => "vagrant",
  hash_code => "aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d",
  filename  => "composer"
}
