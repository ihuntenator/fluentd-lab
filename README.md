# fluentd lab


## Vagrantfile

Start a Centos 7 vm with docker.

```
vagrant up 
vagrant provision
```

## docker-compose.yaml

Start the noise containers and the fluentd container to aggregate the container logs and forward them to HEC.

## fluentd-hec container

```
docker run -d -v /var/lib/docker/containers:/var/lib/docker/containers:Z ihuntenator/fluentd-hec:1.0 fluentd -c /fluentd/etc/fluent.conf
```


### Test container

Run an emitter:

```
docker run --rm registry.access.redhat.com/ubi7:latest /bin/sh -c 'i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done'
```


## Problems

fluentd_tail gets permissoion denied reading contaoiner logs

The log aggregator container is a UBI8 with SeLinux enabled, the Vagrant box is  Centos 7 with SeLinux enabled, the volume mount of /var/lib/docker/containers/ when trying to read the container logs gave a permission denied error, which is unexpected as using the `Z` option on the volume mount.

This solution fixed issue:  https://access.redhat.com/solutions/24845

Which is:
```
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g'  /etc/selinux/config
touch /.autorelabel
reboot
sed -i 's/SELINUX=permissive/SELINUX=enforcing/g'  /etc/selinux/config
touch /.autorelabel
reboot
```
