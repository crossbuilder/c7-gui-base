FROM centos:latest

MAINTAINER crossbuilder

LABEL Version 0.1

RUN cd /etc/yum.repos.d && curl -O https://winswitch.org/downloads/CentOS/winswitch.repo && yum repolist && yum -y update && yum -y install xpra libcanberra PackageKit firefox && yum clean all

RUN dbus-uuidgen >/etc/machine-id 

EXPOSE 22 10010

