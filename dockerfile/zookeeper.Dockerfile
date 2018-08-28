FROM ubuntu:16.04

MAINTAINER Ryan(946065221@qq.com)

RUN apt-get update &&\
    apt-get install -y vim lsof wget

RUN mkdir /opt/java &&\
	wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz -P /opt/java &&\
    tar -zxf /opt/java/jdk-8u181-linux-x64.tar.gz -C /opt/java &&\
	rm /opt/java/jdk-8u181-linux-x64.tar.gz &&\
	touch ~/.bash_profile &&\
    echo 'export PATH=$PATH' >> ~/.bash_profile &&\
	sed -i "/^export PATH/i export JAVA_HOME=/opt/java/jdk1.8.0_181" ~/.bash_profile &&\
	sed -i  's/^export PATH.*$/&:\$JAVA_HOME\/bin/g' ~/.bash_profile

ENV ZOOKEEPER_VERSION "3.4.10"

RUN mkdir /opt/zookeeper &&\
	wget http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz -P /opt/zookeeper &&\
    tar -zxf /opt/zookeeper/zookeeper-$ZOOKEEPER_VERSION.tar.gz -C /opt/zookeeper &&\
	rm /opt/zookeeper/zookeeper-$ZOOKEEPER_VERSION.tar.gz

COPY scripts/zk-start.sh /opt/zookeeper

EXPOSE 2181

ENTRYPOINT ["bash", "/opt/zookeeper/zk-start.sh"]