#!/bin/bash

# Exit on any error
set -e

# Update the system
sudo apt update && sudo apt upgrade -y

# Install Java 8
sudo apt install openjdk-8-jdk -y

# Create hadoop user and configure passwordless SSH
sudo adduser --gecos "" hadoop
sudo usermod -aG sudo hadoop
sudo apt install openssh-server openssh-client -y

# Switch to hadoop user and configure SSH keys
sudo -u hadoop bash <<EOF
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 640 ~/.ssh/authorized_keys
ssh -o StrictHostKeyChecking=no localhost
EOF

# Download and install Hadoop
sudo -u hadoop bash <<EOF
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz
tar -xvzf hadoop-3.3.1.tar.gz
sudo mv hadoop-3.3.1 /usr/local/hadoop
sudo mkdir /usr/local/hadoop/logs
sudo chown -R hadoop:hadoop /usr/local/hadoop
EOF

# Setup environment variables
echo '
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
' | sudo tee -a /home/hadoop/.bashrc

# Set JAVA_HOME in hadoop-env.sh
JAVA_HOME_PATH=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
echo "export JAVA_HOME=$JAVA_HOME_PATH" | sudo tee -a /usr/local/hadoop/etc/hadoop/hadoop-env.sh
echo 'export HADOOP_CLASSPATH+=" $HADOOP_HOME/lib/*.jar"' | sudo tee -a /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# Download javax.activation
sudo wget -P /usr/local/hadoop/lib https://jcenter.bintray.com/javax/activation/javax.activation-api/1.2.0/javax.activation-api-1.2.0.jar

# Configure core-site.xml
sudo tee /usr/local/hadoop/etc/hadoop/core-site.xml > /dev/null <<EOF
<configuration>
   <property>
      <name>fs.default.name</name>
      <value>hdfs://0.0.0.0:9000</value>
      <description>The default file system URI</description>
   </property>
</configuration>
EOF

# Configure HDFS directories
sudo mkdir -p /home/hadoop/hdfs/{namenode,datanode}
sudo chown -R hadoop:hadoop /home/hadoop/hdfs

# Configure hdfs-site.xml
sudo tee /usr/local/hadoop/etc/hadoop/hdfs-site.xml > /dev/null <<EOF
<configuration>
   <property>
      <name>dfs.replication</name>
      <value>1</value>
   </property>
   <property>
      <name>dfs.name.dir</name>
      <value>file:///home/hadoop/hdfs/namenode</value>
   </property>
   <property>
      <name>dfs.data.dir</name>
      <value>file:///home/hadoop/hdfs/datanode</value>
   </property>
</configuration>
EOF

# Configure mapred-site.xml
sudo tee /usr/local/hadoop/etc/hadoop/mapred-site.xml > /dev/null <<EOF
<configuration>
   <property>
      <name>mapreduce.framework.name</name>
      <value>yarn</value>
   </property>
</configuration>
EOF

# Configure yarn-site.xml
sudo tee /usr/local/hadoop/etc/hadoop/yarn-site.xml > /dev/null <<EOF
<configuration>
   <property>
      <name>yarn.nodemanager.aux-services</name>
      <value>mapreduce_shuffle</value>
   </property>
</configuration>
EOF

# Format HDFS NameNode
sudo -u hadoop /usr/local/hadoop/bin/hdfs namenode -format

echo "✅ Apache Hadoop has been installed and configured successfully!"
