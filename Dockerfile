FROM registry.access.redhat.com/ubi7:latest

WORKDIR ${HOME}
USER 0

CMD ["sh", "-c", 'i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done']
