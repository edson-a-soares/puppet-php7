# Puppet-PHP7
==============


A Puppet recipe to install PHP 7.
---------------------------------

Usage
-----

### Setup

```puppet
  # Installing PHP 7
  include php7::install

  # Installing PHP7 packages.
  php7::package { "php7.0-mysql": }
  php7::package { "php7.0-curl": }
  php7::package { "php7.0-mcrypt": }
    or
  php7::package { "php7.0-mysql php7.0-curl php7.0-mcrypt": }

  # Add file info.php.
  php7::phpinfo { "/var/www/html": }
  