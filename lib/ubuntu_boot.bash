#!/bin/bash -v
tempdeb=$(mktemp /tmp/debpackage.XXXXXXXXXXXXXXXXXX) || exit 1
wget -O "$tempdeb" https://apt.puppetlabs.com/puppet6-release-bionic.deb
dpkg -i "$tempdeb"
apt-get update
apt-get -y install puppet-agent
echo "$(/opt/puppetlabs/bin/facter networking.ip) $(hostname).borg.trek $(hostname)" >> /etc/hosts
echo "manager_ip_address manager.borg.trek manager" >> /etc/hosts
/opt/puppetlabs/bin/puppet config set server manager.borg.trek --section main
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
