FROM alpine:latest

# Remove SUID programs
RUN for i in `find / -perm +6000 -type f 2>/dev/null`; do chmod a-s $i; done

# Install Tinc and utility packages
RUN \
    apk --no-cache add \
      net-tools \
      curl \
      tinc

ADD scripts/ /root/scripts

EXPOSE 655/tcp 655/udp

VOLUME /etc/tinc

# Maintainer
LABEL maintainer="zer <zerpex@gmail.com>"
