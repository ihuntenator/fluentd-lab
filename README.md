# fluentd lab

Verify fluentd.conf and verify events to splunk.

## Vagrantfile

Start a Centos 7 vm with docker.

```
vagrant up 
vagrant provision
```



## Problems

### `fluentd_tail` gets permmision denied reading container logs

The log aggregator container is a UBI8 with SeLinux enabled, the Vagrant box is  Centos 7 with SeLinux enabled, the volume mount of /var/lib/docker/containers/ when trying to read the container logs gave a permission denied error, which is unexpected as using the `Z` option on the volume mount.

This solution fixed issue:  https://access.redhat.com/solutions/24845

```
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g'  /etc/selinux/config
touch /.autorelabel
reboot
sed -i 's/SELINUX=permissive/SELINUX=enforcing/g'  /etc/selinux/config
touch /.autorelabel
reboot
```

## To Test

https://www.rubydoc.info/gems/fluent-plugin-docker-tag-resolver

https://github.com/bwalex/fluent-plugin-docker-format
