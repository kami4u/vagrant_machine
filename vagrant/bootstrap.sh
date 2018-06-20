#!/usr/bin/env bash

# Exit if any statement returns a non-true value.
set -e
# Exit when attempting to use an unset variable.
set -u

vagrant=/vagrant/vagrant

# Use 'noninteractive' mode for installing packages and resolving config conflicts.
export DEBIAN_FRONTEND=noninteractive

symlink_vagrant_file()
{
    local path=$1
    local file=$2

    ensure_filepath_exists ${path}

    local link=${path}/${file}
    local target=${vagrant}${path}/${file}

    if [ -f ${target} ]; then
        ln -fs ${target} ${link}
    fi
}

ensure_filepath_exists()
{
    local path=$1

    if ! [ -d ${path} ]; then
        mkdir -p ${path}
    fi
}

provision()
{
    locale-gen en_GB.UTF-8
    sudo apt-get -qq update
    sudo apt-get -y install nodejs npm
}

provision_working_directory()
{
    sudo mkdir -p /data/usp
}

provision_node()
{
    cd /data/usp/example
    npm install express --save --no-bin-links
    nodejs server.js
}

provision
provision_working_directory
provision_node