#!/bin/bash

APTMIRROR_OPTIONS="/repo/conf/mirror.list"

function init() {
    if [ ! -d /repo/conf ]; then
        echo "### (init) Creating default configuration ###"
        mkdir /repo/conf
        cat > /repo/conf/mirror.list << END
############# config ##################
#
# set base_path    /var/spool/apt-mirror
#
# set mirror_path  $base_path/mirror
# set skel_path    $base_path/skel
# set var_path     $base_path/var
# set cleanscript  $var_path/clean.sh
# set defaultarch  <running host architecture>
# set postmirror_script $var_path/postmirror.sh
# set run_postmirror 0
set nthreads     20
set _tilde 0
#
############# end config ##############

# Uubuntu 18.04
deb-amd64 http://archive.ubuntu.com/ubuntu bionic main main/debian-installer main/installer-amd64 restricted universe multiverse
deb-amd64 http://archive.ubuntu.com/ubuntu bionic-security main restricted universe multiverse
deb-amd64 http://archive.ubuntu.com/ubuntu bionic-updates main restricted universe multiverse
#deb-amd64 http://archive.ubuntu.com/ubuntu bionic-proposed main restricted universe multiverse
#deb-amd64 http://archive.ubuntu.com/ubuntu bionic-backports main restricted universe multiverse

deb-i386 http://archive.ubuntu.com/ubuntu bionic main main/debian-installer main/installer-i386 restricted universe multiverse
deb-i386 http://archive.ubuntu.com/ubuntu bionic-security main restricted universe multiverse
deb-i386 http://archive.ubuntu.com/ubuntu bionic-updates main restricted universe multiverse
#deb-i386 http://archive.ubuntu.com/ubuntu bionic-proposed main restricted universe multiverse
#deb-i386 http://archive.ubuntu.com/ubuntu bionic-backports main restricted universe multiverse

#deb-src http://archive.ubuntu.com/ubuntu bionic main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu bionic-security main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu bionic-updates main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu bionic-proposed main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu bionic-backports main restricted universe multiverse

# Uubuntu 16.04
#deb-amd64 http://archive.ubuntu.com/ubuntu xenial main main/debian-installer main/installer-amd64 restricted universe multiverse
#deb-amd64 http://archive.ubuntu.com/ubuntu xenial-security main restricted universe multiverse
#deb-amd64 http://archive.ubuntu.com/ubuntu xenial-updates main restricted universe multiverse
#deb-amd64 http://archive.ubuntu.com/ubuntu xenial-proposed main restricted universe multiverse
#deb-amd64 http://archive.ubuntu.com/ubuntu xenial-backports main restricted universe multiverse

#deb-i386 http://archive.ubuntu.com/ubuntu xenial main main/debian-installer main/installer-i386 restricted universe multiverse
#deb-i386 http://archive.ubuntu.com/ubuntu xenial-security main restricted universe multiverse
#deb-i386 http://archive.ubuntu.com/ubuntu xenial-updates main restricted universe multiverse
#deb-i386 http://archive.ubuntu.com/ubuntu xenial-proposed main restricted universe multiverse
#deb-i386 http://archive.ubuntu.com/ubuntu xenial-backports main restricted universe multiverse

#deb-src http://archive.ubuntu.com/ubuntu xenial main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu xenial-security main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu xenial-updates main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu xenial-proposed main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu xenial-backports main restricted universe multiverse

# Uubuntu 14.04
#deb-amd64 http://archive.ubuntu.com/ubuntu trusty main main/debian-installer main/installer-amd64 restricted universe multiverse
#deb-amd64 http://archive.ubuntu.com/ubuntu trusty-security main restricted universe multiverse
#deb-amd64 http://archive.ubuntu.com/ubuntu trusty-updates main restricted universe multiverse
#deb-amd64 http://archive.ubuntu.com/ubuntu trusty-proposed main restricted universe multiverse
#deb-amd64 http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse

#deb-i386 http://archive.ubuntu.com/ubuntu trusty main main/debian-installer main/installer-i386 restricted universe multiverse
#deb-i386 http://archive.ubuntu.com/ubuntu trusty-security main restricted universe multiverse
#deb-i386 http://archive.ubuntu.com/ubuntu trusty-updates main restricted universe multiverse
#deb-i386 http://archive.ubuntu.com/ubuntu trusty-proposed main restricted universe multiverse
#deb-i386 http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse

#deb-src http://archive.ubuntu.com/ubuntu trusty main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu trusty-security main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu trusty-updates main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu trusty-proposed main restricted universe multiverse
#deb-src http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse

clean http://archive.ubuntu.com/ubuntu
END

    fi

    if [ ! -d /repo/repo ]; then
        echo "### (init) Creating download directory ###"
        mkdir /repo/repo
    fi 
}

if [ "$1" = "init" ]; then
    init
    exit 0
fi

if [ "${1:0:1}" != '-' ]; then
    exec $1
fi

init

if [ "$PROXY" != "" ]; then
    export http_proxy=${PROXY}
    export https_proxy=${PROXY}
fi

rm -rf /var/spool/apt-mirror
ln -s /repo/repo /var/spool/apt-mirror

echo "### Downloding repositories ###"
if [ "$1" != "" ]; then
    APTMIRROR_OPTIONS="$APTMIRROR_OPTIONS $@"
    echo "apt-mirror options = $APTMIRROR_OPTIONS"
fi

apt-mirror $APTMIRROR_OPTIONS
if [ $? -ne 0 ]; then
    echo "ERROR: apt-mirror"
    exit 1
fi

echo "apt-mirror completed"

exit 0
