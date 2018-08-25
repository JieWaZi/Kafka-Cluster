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

ENV KAFKA_VERSION "2.0.0"

RUN mkdir /opt/kafka &&\
	wget http://mirror.bit.edu.cn/apache/kafka/$KAFKA_VERSION/kafka_2.11-$KAFKA_VERSION.tgz -P /opt/kafka &&\
	tar -zxf /opt/kafka/kafka_2.11-$KAFKA_VERSION.tgz -C /opt/kafka/ &&\
	rm /opt/kafka/kafka_2.11-$KAFKA_VERSION.tgz &&\
	sed -i 's/num.partitions.*$/num.partitions=3/g' /opt/kafka/kafka_2.11-$KAFKA_VERSION/config/server.properties

COPY kf-start.sh /opt/kafka

EXPOSE 9092

ENTRYPOINT ["bash", "/opt/kafka/kf-start.sh"]