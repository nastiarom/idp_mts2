#!/bin/bash

JUMP_NODE=$1
USER=$2
NAMENODE=$3
DATANODE1=$4
DATANODE2=$5

ssh "$USER@$JUMP_NODE" << EOF
sudo -i -u hadoop

ssh $NAMENODE "rm -r /tmp/hadoop-hadoop/"
ssh $DATANODE1 "rm -r /tmp/hadoop-hadoop/"
ssh $DATANODE2 "rm -r /tmp/hadoop-hadoop/"

ssh $NAMENODE << INNER_EOF
hadoop-3.4.0/bin/hdfs namenode -format
hadoop-3.4.0/sbin/start-dfs.sh
exit
INNER_EOF

exit
EOF