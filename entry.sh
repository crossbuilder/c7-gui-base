#!/bin/sh

set -x

pid=0

echo xpra user: $XPRA_USER
echo pw: $XPRA_PW

if [ ! -f /etc/machine-id ]; then
  dbus-uuidgen >/etc/machine-id 
fi

if [ ! -d /home/${XPRA_USER} ]; then
  useradd -m ${XPRA_USER} && echo "${XPRA_USER}:${XPRA_PW}" | chpasswd
fi

usermod -aG dialout ${XPRA_USER} 

echo executin: "$@"

/root/prepare.sh
su ${XPRA_USER} -c "/usr/bin/run_xpra.sh $@"

sleep 2
tail -f /home/${XPRA_USER}/.xpra/*.log &
pid="$!"

trap "echo TRAPed signal ; kill $pid " HUP INT QUIT TERM KILL 
wait $pid

echo "killing .."
ps aux
su - ${XPRA_USER} -c "xpra stop"
ps aux
echo "bye"