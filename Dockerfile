FROM ubuntu:16.04
MAINTAINER ByS Control "info@bys-control.com.ar"

# Remove SUID programs
RUN for i in `find / -perm +6000 -type f 2>/dev/null`; do chmod a-s $i; done

# Install Tinc and utility packages
RUN apt-get update && \
apt-get install -y build-essential libncurses5-dev libreadline6-dev libzlcore-dev zlib1g-dev liblzo2-dev libssl-dev && \
apt-get install -y net-tools supervisor curl && \
cd /tmp && \
curl -o tinc.tgz http://tinc-vpn.org/packages/tinc-1.1pre14.tar.gz && \
tar zxvf tinc.tgz && cd tinc-1.1pre14 && ./configure && make && make install && \
apt-get autoremove -y build-essential libncurses5-dev libreadline6-dev libzlcore-dev zlib1g-dev liblzo2-dev libssl-dev && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD scripts/ /root/scripts

EXPOSE 655/tcp 655/udp
VOLUME /etc/tinc

ENTRYPOINT [ "/usr/bin/supervisord" ]
