# -*- mode: ruby -*-
# vi: set ft=ruby :

$lab_simple_tdagent = <<-'SCRIPT'
timedatectl set-timezone Pacific/Auckland
echo "192.168.1.71 splunk.local splunk" >> /etc/hosts
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce docker-ce-cli containerd.io
systemctl enable docker.service
systemctl start docker.service
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
mkdir -p /opt/fluentd/etc
curl https://raw.githubusercontent.com/ihuntenator/fluentd-lab/master/docker-compose.yaml -o docker-compose.yaml
curl https://raw.githubusercontent.com/ihuntenator/fluentd-lab/master/Dockerfile -o Dockerfile
curl https://raw.githubusercontent.com/ihuntenator/fluentd-conf/master/fluentd.conf.in_file.hec -o /opt/fluentd-hec/fluentd/etc/fluentd.conf
docker-compose up -d
SCRIPT

# td-agent VM
Vagrant.configure("2") do |config|
  config.vm.define "tdagent_simple" do |tdagent_simple|
    tdagent_simple.vm.box = "centos/7"
    tdagent_simple.vm.hostname = 'tdagent'
    tdagent_simple.vm.network :private_network, ip: "172.16.94.40"
    tdagent_simple.vm.provider :virtualbox do |v|
    tdagent_simple.vm.synced_folder ".", "/vagrant", type: "virtualbox"
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "tdagent"]
    end
    tdagent_simple.vm.provision "shell", inline: $lab_simple_tdagent
  end
end
