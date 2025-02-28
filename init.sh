#!/bin/bash

JUMP_NODE=$1
USER=$2
NAMENODE=$3
DATANODE1=$4
DATANODE2=$5

./clean.sh "$JUMP_NODE" "$USER" "$NAMENODE" "$DATANODE1" "$DATANODE2"

./nginx-setup.sh "$JUMP_NODE" "$USER" "$NAMENODE"

./yarn-setup.sh "$JUMP_NODE" "$USER" "$NAMENODE" "$DATANODE1" "$DATANODE2"

./nginx-yarn-history-setup.sh "$JUMP_NODE" "$USER" "$NAMENODE"