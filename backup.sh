#!/bin/bash
NOW=$(date +"%Y-%m-%d_%H:%M:%S")

BACKUPS=$HOME/backups
PAPER1165=$HOME/paper_1165
CREATIVE=$HOME/creative

if [ ! -e $BACKUPS ]; then
        mkdir -p $BACKUPS
fi

cd $BACKUPS
screen -S survival -X stuff "save-all^M"
sleep 5
screen -S survival -X stuff "say creating backup_${NOW}^M"
/sbin/btrfs subvolume snapshot $PAPER1165 "${BACKUPS}/backup_${NOW}"

NOW=$(date +"%Y-%m-%d_%H:%M:%S")
screen -S creative -X stuff "stop^M"
screen -S survival -X stuff "say syncing to creative ${NOW}^M"
if [ ! -e $CREATIVE ]; then
       mkdir -p $CREATIVE
fi
cp --reflink -r $PAPER1165/* $CREATIVE
cp $HOME/creative-settings/* $CREATIVE

NOW=$(date +"%Y-%m-%d_%H:%M:%S")
screen -S survival -X stuff "say compressing backup ${NOW}^M"
cd $HOME
tar cfJ creative.tar.xz creative/

NOW=$(date +"%Y-%m-%d_%H:%M:%S")
screen -S survival -X stuff "say starting creative server ${NOW} ^M"
$PAPER1165/scripts/start_server.sh $CREATIVE creative

screen -S survival -X stuff "say backup done, disk free^M"
df . -h | while read -r line
do
    screen -S survival -X stuff "say $line^M"
done
