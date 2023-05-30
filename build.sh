#!/bin/bash
set -x
builddir="localbuilddir"
currentdir=$(pwd)
sudo apt-get -y -q update
sudo apt-get -y -q install debootstrap ca-certificates
sudo cp /usr/share/keyrings/ubuntu-master-keyring.gpg /etc/apt/trusted.gpg.d/
sudo debootstrap --arch arm64 --variant=minbase --include=sudo,curl,systemd,postgresql,locales,ca-certificates,apt-utils,wget jammy $builddir http://archive.ubuntu.com/ubuntu/
sudo cp config.sh $builddir
sudo cp config-db.sh $builddir
sudo cp run.sh $builddir
sudo chroot $builddir /bin/bash /config.sh
sudo chroot --userspec=postgres $builddir /bin/bash /config-db.sh
sudo rm -r $builddir/var/cache/apt/archives/*
sudo rm $builddir/*.deb
sudo rm $builddir/get-docker.sh
sudo rm $builddir/config.sh
sudo rm $builddir/config-db.sh
sudo rm $builddir/.postgrespw
cd $builddir
sudo tar --ignore-failed-read -czf /tmp/install.tar.gz *
sudo mv /tmp/install.tar.gz $currentdir
sudo apt-get clean
cd $currentdir
