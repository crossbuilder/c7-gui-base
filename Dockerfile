FROM docker.io/centos:latest
MAINTAINER crossbuilder
LABEL Version 0.3
# v0.3 
#   enable systemd based on vlisivka/docker-centos7-systemd-unpriv
#     by copy/past and installation of 
#     https://github.com/vlisivka/docker-centos7-systemd-unpriv/releases/download/v1.0/docker-centos7-systemd-unpriv-1.0-1.el7.centos.noarch.rpm     


ENV container docker

# NOTE: Systemd needs /sys/fs/cgroup directoriy to be mounted from host in
# read-only mode. (Required).
VOLUME [ "/sys/fs/cgroup" ]

# Systemd needs /run directory to be a mountpoint, otherwise it will try
# to mount tmpfs here (and will fail).  (Required).
VOLUME [ "/run" ]

RUN yum -y update \
	&& yum -y install epel-release \
	&& yum repolist \
#	&& rpm -i --force --nosignature --nodeps http://mirror.centos.org/centos/7/os/x86_64/Packages/gnome-keyring-3.14.0-1.el7.x86_64.rpm ; true \
	&& yum -y groupinstall "MATE Desktop" \
	&& yum -y install lightdm \
	&& yum -y install openssh libcanberra-gtk2 PackageKit PackageKit-gtk3-module xterm firefox rsync \
	&& yum clean all

RUN cd /etc/yum.repos.d \
	&& curl -O https://winswitch.org/downloads/CentOS/winswitch.repo \
#	&& rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm \
	&& yum -y install xpra \
	&& yum clean all

#RUN rpm -vi https://github.com/vlisivka/docker-centos7-systemd-unpriv/releases/download/v1.0/docker-centos7-systemd-unpriv-1.0-1.el7.centos.noarch.rpm \
#RUN dbus-uuidgen >/etc/machine-id 

#RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
#rm -f /lib/systemd/system/multi-user.target.wants/*;\
#rm -f /etc/systemd/system/*.wants/*;\
#rm -f /lib/systemd/system/local-fs.target.wants/*; \
#rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
#rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
#rm -f /lib/systemd/system/basic.target.wants/*;\
#rm -f /lib/systemd/system/anaconda.target.wants/*;

#CMD [ "/usr/sbin/init" ]

EXPOSE 22 10010

