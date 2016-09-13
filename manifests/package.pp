define php7::package ($package_name = $title) {

    Class[ "php7::install" ] -> PHP7::Package[$title]

    exec { "install-package-$title":
        command => "sudo apt-get install --yes $package_name",
        path    => "/usr/bin/",
    }

}
