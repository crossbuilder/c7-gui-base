#!/bin/sh

set -x

pid=0

echo xpra user: $XPRA_USER
echo pw: $XPRA_PW

if [ "x$DRY" == "xNO" ]; then

  if [ ! -s /etc/machine-id ]; then
    dbus-uuidgen >/etc/machine-id 
  fi

  useradd -m ${XPRA_USER} && echo "${XPRA_USER}:${XPRA_PW}" | chpasswd

  echo executin: "$@"

  /root/prepare.sh

  su ${XPRA_USER} -c "/usr/bin/run_xpra.sh $@"

  sleep 2
  tail -f /home/${XPRA_USER}/.xpra/*.log &
  pid="$!"
else
  tail -f /var/log/messages &
  pid="$!"
fi

trap "echo TRAPed signal ; kill $pid " HUP INT QUIT TERM KILL 
rm /var/run/nologin
wait $pid

echo "killing .."
ps aux
su - ${XPRA_USER} -c "xpra stop"
ps aux
echo "bye"
