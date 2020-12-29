FROM registry.access.redhat.com/ubi7:latest

ENV TZ=Pacific/Auckland
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD bash -c i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 3; done
