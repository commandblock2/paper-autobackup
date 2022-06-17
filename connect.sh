#!/bin/bash

DESTPORT=${1:-25575}
SRCPORT=${2:-25565}
TARGET=${3:-paper1165@localhost}

COMMAND="autossh -M -0 -R 0.0.0.0:${DESTPORT}:127.0.0.1:${SRCPORT} ${TARGET} -o ServerAliveInterval=10 -o ServerAliveCountMax=300 -o ExitOnForwardFailure=yes"
if pgrep -f "${COMMAND}" > /dev/null
then
        echo "tunnel already established, no need to establish another one, exiting"
        exit
fi

screen -S ssh-port-tunnel$SRCPORT-$DESTPORT -dm $COMMAND
