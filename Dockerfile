FROM centos:latest

MAINTAINER crossbuilder

LABEL Version 0.2

RUN cd /etc/yum.repos.d \
	&& curl -O https://winswitch.org/downloads/CentOS/winswitch.repo \
	&& yum repolist \
	&& yum -y update \
	&& yum -y install xpra libcanberra-gtk2 PackageKit PackageKit-gtk3-module xterm firefox \
	&& yum -y install rsync gnome-terminal \
	&& yum clean all

RUN dbus-uuidgen >/etc/machine-id 

EXPOSE 22 10010

