#!/bin/bash
set -x
echo '[boot]' >> /etc/wsl.conf && echo 'systemd=true' >> /etc/wsl.conf
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
update-locale LANGUAGE=en_US.UTF-8 LC_ALL=C
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
curl -s https://api.github.com/repos/determined-ai/determined/releases/latest | grep "browser_download_url.*_linux_amd64.deb" | cut -d : -f 2,3 | tr -d \" | wget -qi -
dpkg -i *.deb
systemctl enable postgresql determined-master determined-agent
chown -R postgres:postgres /var/lib/postgresql
chown -R postgres:postgres /var/run/postgresql
postgrespw=$(echo $RANDOM | md5sum | head -c 20)
echo $postgrespw > .postgrespw
sed -i 's/# password: database_password/password: '"$postgrespw"'/g' /etc/determined/master.yaml
sed -i 's/# host: determined-db/host: localhost/g' /etc/determined/master.yaml
sed -i 's/# master_host: 0.0.0.0/master_host: localhost/g' /etc/determined/agent.yaml
sed -i 's/# master_port: 80/master_port: 8080/g' /etc/determined/agent.yaml
sed -i '10i \Environment=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/lib/wsl/lib/' /lib/systemd/system/determined-agent.service
echo "bash /run.sh" >> /etc/profile