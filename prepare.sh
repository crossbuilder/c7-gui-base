#!/bin/bash
echo "prepare"
# save to do on each run, the key are only generated, if they don't exists
cp -van /root/backup-ssh/* /etc/ssh/
sshd-keygen
#start ssh daemon
/usr/sbin/sshd
