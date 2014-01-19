default[:nodejs][:base_dir]       = "/usr/local/nvm"
default[:nodejs][:global_version] = "0.10.24"
default[:nodejs][:versions]       = ["0.10.24"]

default[:nodejs][:packages] = [
    {:name => "coffee-script", :command => "coffee"},
    {:name => "typescript",    :command => "tsc"},
    {:name => "grunt-cli",     :command => "grunt"}
]
