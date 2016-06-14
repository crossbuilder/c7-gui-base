FROM docker.io/centos:latest
MAINTAINER crossbuilder
LABEL Version 0.3

ENV container docker

# NOTE: Systemd needs /sys/fs/cgroup directoriy to be mounted from host in
# read-only mode. (Required).
# VOLUME [ "/sys/fs/cgroup" ]

# Systemd needs /run directory to be a mountpoint, otherwise it will try
# to mount tmpfs here (and will fail).  (Required).
VOLUME [ "/run" ]

RUN yum -y update \
	&& yum -y install epel-release \
	&& yum repolist \
	&& yum -y groupinstall "MATE Desktop" \
	&& yum -y install lightdm \
	&& yum -y install openssh libcanberra-gtk2 PackageKit PackageKit-gtk3-module xterm firefox rsync \
	&& yum clean all

RUN cd /etc/yum.repos.d \
	&& curl -O https://winswitch.org/downloads/CentOS/winswitch.repo \
	&& yum -y install xpra \
	&& yum clean all

EXPOSE 22 10010

