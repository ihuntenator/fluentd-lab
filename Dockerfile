FROM registry.access.redhat.com/ubi7:latest

CMD bash -c i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 3; done
