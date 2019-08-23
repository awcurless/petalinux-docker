FROM ubuntu:16.04
MAINTAINER Adrian Curless (awcurless@wpi.edu)

ARG installer

RUN mkdir /home/petalinux

COPY $installer /home/petalinux/petalinux.run

RUN rm -rf /opt/pkg/petalinux
RUN mkdir -p /opt/pkg/petalinux

RUN cat /etc/resolv.conf

RUN dpkg --add-architecture i386
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
  build-essential \
  sudo \
  tofrodos \
  iproute2 \
  gawk \
  net-tools \
  expect \
  libncurses5-dev \
  tftpd \
  update-inetd \
  libssl-dev \
  flex \
  bison \
  libselinux1 \
  gnupg \
  wget \
  socat \
  gcc-multilib \
  libsdl1.2-dev \
  libglib2.0-dev \
  lib32z1-dev \
  zlib1g:i386 \
  libgtk2.0-0 \
  screen \
  pax \
  diffstat \
  xvfb \
  xterm \
  texinfo \
  gzip \
  unzip \
  cpio \
  chrpath \
  autoconf \
  lsb-release \
  libtool \
  libtool-bin \
  locales \
  kmod \
  git \
  rsync \
  bc \
  u-boot-tools \
  vim
RUN apt-get clean

RUN locale-gen en_US.UTF-8 && update-locale

RUN echo "%sudo ALL=(ALL:ALL) ALL" >> /etc/sudoers
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN useradd -ms /bin/bash petalinux
RUN usermod -aG sudo petalinux

RUN chown -R petalinux /home/petalinux
RUN chown -R petalinux /opt
RUN chmod +x /home/petalinux/petalinux.run

USER petalinux
WORKDIR /home/petalinux

RUN yes | /home/petalinux/petalinux.run /opt/pkg/petalinux > /dev/null || true

RUN echo 'alias petalinuxenv="source /opt/pkg/petalinux/settings.sh"' >> $HOME/.bashrc

ENV HOME /home/petalinux
ENV LANG en_US.UTF-8

ENTRYPOINT /bin/bash
