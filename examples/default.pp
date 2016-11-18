# Install PHP7 and some packages
include php7::install

# Install PHP7 Packages
php7::package { "php7.0-fpm": } ->
php7::package { "php7.0-mysql": } ->
php7::package { "php7.0-curl php7.0-mcrypt": }

# Add PHPInfo file
php7::phpinfo { "/var/www/html": }

exec { "create-customize-homeuser":
  command => "sudo adduser ubuntu",
  path    => [ "/usr/bin", "/bin" ],
  unless  => "grep -c '^ubuntu:' /etc/passwd"
} ->

# Install Composer
php7::composer { "/usr/local/bin":
  home_user => "ubuntu",
  filename  => "composer"
}
