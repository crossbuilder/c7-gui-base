#!/bin/bash
set +x
echo xpra user passwd: ${XPRA_PW}
#INITENV
xpra start  --bind-tcp=0.0.0.0:10010 --tcp-auth=password:value=${XPRA_PW} --sharing=yes --start-new-commands=yes --speaker=off  :7007 "$@"
