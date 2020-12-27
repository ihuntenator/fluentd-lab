# -*- mode: ruby -*-
# vi: set ft=ruby :

$lab_simple_tdagent = <<-'SCRIPT'
yum install -y docker 
sed -i 's/--log-driver=journald/--log-driver=json-file/g' /etc/sysconfig/docker
systemctl enable docker.service
systemctl start docker.service
docker run -d -v /var/lib/docker/containers:/ontainers ihuntenator/fluentd-hec:1.1 fluentd -c /fluentd/etc/fluentd.conf
SCRIPT

# td-agent VM
Vagrant.configure("2") do |config|
  config.vm.define "tdagent_simple" do |tdagent_simple|
    tdagent_simple.vm.box = "centos/7"
    tdagent_simple.vm.hostname = 'tdagent'
    tdagent_simple.vm.network :private_network, ip: "172.16.94.40"
    tdagent_simple.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    tdagent_simple.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "tdagent"]
    end
    tdagent_simple.vm.provision "shell", inline: $lab_simple_tdagent
  end
end
