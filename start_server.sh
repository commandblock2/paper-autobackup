#!/bin/bash

SERVER=${1:-$HOME/paper_1165}
cd $SERVER

SESSION=${2:-survival}

JAVA="java"
PAPER="${SERVER}/paper-1.16.5-794.jar"

COMMAND="${JAVA} -Xms6G -Xmx6G -Dlog4j2.formatMsgNoLookups=true -jar ${PAPER}"

if pgrep -f "${COMMAND}" > /dev/null
then
        echo "server already started, no need to start again, script exiting"
        exit
fi
screen -S $SESSION -dm $COMMAND
