FROM debian:experimental
MAINTAINER ByS Control "info@bys-control.com.ar"

# Remove SUID programs
RUN for i in `find / -perm +6000 -type f 2>/dev/null`; do chmod a-s $i; done

# Install Tinc and utility packages
RUN echo "deb http://http.debian.net/debian experimental main" >> /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y net-tools supervisor curl && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -t experimental tinc && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD scripts/ /root/scripts

EXPOSE 655/tcp 655/udp
VOLUME /etc/tinc

ENTRYPOINT [ "/usr/bin/supervisord" ]
