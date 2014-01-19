default[:php][:base_dir]         = "/usr/local/phpenv"
default[:php][:global_version]   = "5.5.8"
default[:php][:configure_option] = ""
default[:php][:versions] = [
    {
        :version => "5.5.8",
        :ini     => "5_5"
    },
    {
        :version => "5.4.24",
        :ini     => "5_4"
    },
    {
        :version => "5.3.28",
        :ini     => "5_3"
    },
    {
        :version => "5.2.17",
        :ini     => "5_2"
    }
]
