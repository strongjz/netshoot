FROM alpine:3.11

RUN set -ex \
    && echo "http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    apache2-utils \
    bash \
    bind-tools \
    bird \
    bridge-utils \
    busybox-extras \
    conntrack-tools \
    curl \
    dhcping \
    drill \
    ethtool \
    file\
    fping \
    iftop \
    iperf \
    iproute2 \
    ipset \
    iptables \
    iptraf-ng \
    iputils \
    ipvsadm \
    libc6-compat \
    liboping \
    mtr \
    net-snmp-tools \
    netcat-openbsd \
    nftables \
    ngrep \
    nmap \
    nmap-nping \
    openssl \
    openssl-dev \
    python3-dev \
    py-crypto \
    py3-virtualenv \
    python3 \
    scapy \
    socat \
    strace \
    tcpdump \
    tcptraceroute \
    util-linux \
    wget \
    vim

# apparmor issue #14140
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump

# Installing ctop - top-like container monitor
RUN wget https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64 -O /usr/local/bin/ctop && chmod +x /usr/local/bin/ctop

# Installing calicoctl
ARG CALICOCTL_VERSION=v3.3.1
RUN wget https://github.com/projectcalico/calicoctl/releases/download/${CALICOCTL_VERSION}/calicoctl && chmod +x calicoctl && mv calicoctl /usr/local/bin

# Installing coreDNS
ADD https://github.com/coredns/coredns/releases/download/v1.6.9/coredns_1.6.9_linux_arm64.tgz /coredns.tgz
RUN tar -xzvf /coredns.tgz && rm -f /coredns.tgz

# Settings
ADD motd /etc/motd
ADD profile  /etc/profile

CMD ["/bin/bash","-l"]
