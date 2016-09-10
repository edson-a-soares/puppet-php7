# Puppet-PHP7


A Puppet recipe to install and configure PHP 7 and its packages.
----------------------------------------------------------------

###Usage

**Installing PHP7**
~~~
    include php7::install
~~~

**Installing PHP7 Packages**
~~~
    php7::package { "php7.0-mysql": }
    php7::package { "php7.0-curl": }
    php7::package { "php7.0-mcrypt": }
~~~

or

~~~
    php7::package { "php7.0-mysql php7.0-curl php7.0-mcrypt": }
~~~

**Add PHPInfo file**
~~~
    php7::phpinfo { "/var/www/html": }
~~~

###Dependencies
 * puppetlabs/apt

### Limitations
This module has been tested only on Ubuntu 14.04 Trusty using Puppet versions 3.4 and later.

### License

                Copyright 2016 Edson A. Soares

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
