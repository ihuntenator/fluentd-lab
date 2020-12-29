# fluentd lab


## Vagrantfile

Centos 7 vm with docker.

Update, install the guest plugin and start up the tdagent test vm.
```
vagrant box update --box centos/7
vagrant plugin install vagrant-vbguest
vagrant up --provision
```

## docker-compose.yaml

Start the noise containers and the fluentd container to aggregate the container logs and forward them to HEC.

## fluentd-hec container

Run the aggregator container:
```
docker run -d -v /var/lib/docker/containers:/containers ihuntenator/fluentd-hec:1.0 fluentd -c /fluentd/etc/fluent.conf
```

### Test container

```
docker run --rm registry.access.redhat.com/ubi7:latest /bin/sh -c 'i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done'
```
