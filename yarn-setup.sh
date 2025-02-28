#!/bin/bash

JUMP_NODE=$1
USER=$2
NAMENODE=$3
DATANODE1=$4
DATANODE2=$5

ssh "$USER@$JUMP_NODE" << EOF
sudo -i -u hadoop

cd hadoop-3.4.0/etc/hadoop/
cat > yarn-site.xml << CONFIG
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.env-whitelist</name>
        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_HOME,PATH,LANG,TZ,HADOOP_MAPRED_HOME</value>
    </property>
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>$NAMENODE</value>
    </property>
    <property>
        <name>yarn.resourcemanager.address</name>
        <value>$NAMENODE:8032</value>
    </property>
    <property>
        <name>yarn.resourcemanager.resource-tracker.address</name>
        <value>$NAMENODE:8031</value>
    </property>
</configuration>
CONFIG

cat > mapred-site.xml << CONFIG
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapreduce.application.classpath</name>
        <value>\$HADOOP_HOME/share/hadoop/mapreduce/*:\$HADOOP_HOME/share/hadoop/mapreduce/lib/*</value>
    </property>
</configuration>
CONFIG

scp yarn-site.xml $DATANODE1:/home/hadoop/hadoop-3.4.0/etc/hadoop
scp yarn-site.xml $DATANODE2:/home/hadoop/hadoop-3.4.0/etc/hadoop
scp mapred-site.xml $DATANODE1:/home/hadoop/hadoop-3.4.0/etc/hadoop
scp mapred-site.xml $DATANODE2:/home/hadoop/hadoop-3.4.0/etc/hadoop

scp yarn-site.xml $NAMENODE:/home/hadoop/hadoop-3.4.0/etc/hadoop
scp mapred-site.xml $NAMENODE:/home/hadoop/hadoop-3.4.0/etc/hadoop

ssh $NAMENODE << INNER_EOF
hadoop-3.4.0/sbin/start-yarn.sh
mapred --daemon start historyserver
exit
INNER_EOF

exit
EOF