FROM ubuntu:16.04
MAINTAINER ByS Control "info@bys-control.com.ar"

# Remove SUID programs
RUN for i in `find / -perm +6000 -type f 2>/dev/null`; do chmod a-s $i; done

# Based on https://nwgat.ninja/quick-easy-tinc-1-1-2/
# Install packages
RUN apt-get update && \
apt-get install -y build-essential libncurses5-dev libreadline6-dev libzlcore-dev zlib1g-dev liblzo2-dev libssl-dev && \
apt-get install -y --no-install-recommends net-tools supervisor curl && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build tinc
RUN curl http://tinc-vpn.org/packages/tinc-1.1pre14.tar.gz | tar xzC /tmp && \
cd /tmp/tinc-1.1pre14 && ./configure && make && make install

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD scripts/ /root/scripts

EXPOSE 655/tcp 655/udp
VOLUME /etc/tinc

ENTRYPOINT [ "/usr/bin/supervisord" ]
