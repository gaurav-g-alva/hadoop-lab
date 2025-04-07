#!/bin/bash

echo "|------------------------------------------|"
echo "|--Update Command-- $ sudo apt update      |"
echo "|------------------------------------------|"
sudo apt update

echo "|------------------------------------------|"
echo "|--Upgrade Command-- $ sudo apt upgrade    |"
echo "|------------------------------------------|"
sudo apt upgrade

echo "|--------------------------------------------------------|"
echo "|--Java Installation-- sudo apt install openjdk-8-jdk -y |"
echo "|--------------------------------------------------------|"
sudo apt install openjdk-8-jdk -y


echo "|-------------------------------|"
echo "|--JAVA VERSION-- java -version |"
echo "|-------------------------------|"
java -version


echo "|------------------------------------------------------------------------------------|"
echo "| $ sudo adduser hadoop                                                              |"
echo "| $ sudo usermod -aG sudo hadoop                                                     |"
echo "| $ sudo su – hadoop                                                                 |"
echo "| $ sudo apt install openssh-server openssh-client -y                                |"
echo "| $ sudo su - hadoop                                                                 |"
echo "| $ ssh-keygen -t rsa -P '' -f  ~/.ssh/id_rsa                                        |"
echo "| $ sudo cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys                             |"
echo "| $ sudo chmod 640 ~/.ssh/authorized_keys                                            |"
echo "| $ ssh localhost                                                                    |"
echo "| $ sudo su - hadoop                                                                 |"
echo "| $ wget https://downloads.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz |"
echo "| $ tar -xvzf hadoop-3.3.1.tar.gz                                                    |"
echo "| $ sudo mv hadoop-3.3.1 /usr/local/hadoop                                           |"
echo "| $ sudo mkdir /usr/local/hadoop/logs                                                |"
echo "| $ sudo chown -R hadoop:hadoop /usr/local/hadoop                                    |"
echo "| $ sudo nano ~/.bashrc                                                              |"
echo "| $ source ~/.bashrc                                                                 |"
echo "| $ which javac                                                                      |"
echo "| $ readlink -f /usr/bin/javac                                                       |"
echo "| $ sudo nano $HADOOP_HOME/etc/hadoop/hadoop-env.sh                                  |"
echo "| $ cd /usr/local/hadoop/lib                                                         |"
echo "| $ sudo wget https://jcenter.bintray.com/javax/activation/javax.activation-api/1.2.0/javax.activation-api-1.2.0.jar |"
echo "| $ hadoop version                                                                   |"
echo "| $ sudo nano $HADOOP_HOME/etc/hadoop/core-site.xml                                  |"
echo "| $ sudo mkdir -p /home/hadoop/hdfs/{namenode,datanode}                              |"
echo "| $ sudo chown -R hadoop:hadoop /home/hadoop/hdfs                                    |"
echo "| $ sudo nano $HADOOP_HOME/etc/hadoop/hdfs-site.xml                                  |"
echo "| $ sudo nano $HADOOP_HOME/etc/hadoop/mapred-site.xml                                |"
echo "| $ sudo nano $HADOOP_HOME/etc/hadoop/yarn-site.xml                                  |"
echo "| $ sudo su - hadoop                                                                 |"
echo "| $ hdfs namenode -format                                                            |"
echo "| $ start-dfs.sh                                                                     |"
echo "| $ start-yarn.sh                                                                    |"
echo "| $ jps                                                                              |"
echo "| |"
echo "|------------------------------------------------------------------------------------|"

