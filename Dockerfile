FROM OM 192.168.1.30/fn_base_images/centos:latest
MAINTAINER yehui "i "1750371836@qq.com"
ENV JAVA_HOME=/usr/java/jdk
ENV JOB_HOME=/usr/local/fn
ENV JOB_NAME=jenkins
ENV JENKINS_HOME=/data/jenkins

RUN yum -y install vim lsof wget tar unzip  net-tools git

RUN mkdir -p /usr/java/

COPY PY jdk-8u121-linux-x64.tar.gz /us /usr/java/

RUN tar zxf /usr/java/va/jdk-8u121-linux-x64.tar.gz -C  -C /usr/java && \
    cd /usr/java/ && \
    mv jdk1.8.0_121 jdk && \
    echo "export JAVA_HOME=/usr/java/jdk" >> /etc/profile && \
    echo "export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib" >> /etc/profile && \
    echo "export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH:$HOMR/bin" >> /etc/profile && \
    rm -rf rf jdk-8u121-linux-x64.tar.gz &&  && \
    source /etc/profile

RUN wget et http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz -P  -P /tmp

RUN mkdir -p ${JOB_HOME} && \
    cd /tmp && \
    tar -xzf zf apache-maven-3.3.9-bin.tar.gz &&  && \
    mv apache-maven-3.3.9 ${JOB_HOME}/maven && \
    echo "export MAVEN_HOME=/usr/local/fn/maven" >> /etc/profile && \
    echo "export PATH=$PATH:$MAVEN_HOME/bin" >> /etc/profile && \
    rm -rf /tmp/mp/apache-maven-3.3.9-bin.tar.gz &&  && \
    source /etc/profile

RUN wget  http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz -P  -P /tmp

volume /data/jenkins

RUN cd /tmp && \
    tar xzf zf apache-tomcat-7.0.69.tar.gz -C  -C ${JOB_HOME} && \
    mv ${JOB_HOME}/apache-tomcat-7.0.69 ${JOB_HOME}/tomcat-${JOB_NAME:-job} && \
    rm -rf rf apache-tomcat-7.0.69.tar.gz &&  && \
    rm -rf ${JOB_HOME}/tomcat-${JOB_NAME}/webapps/* && \
    sed -i 's#<Connector port="8080" protocol="HTTP/1.1"#<Connector port="2080" protocol="HTTP/1.1" URIEncoding="UTF-8"#g' ${JOB_HOME}/tomcat-${JOB_NAME}/conf/nf/server.xml &&  && \
    sed -i 's#<Server port="8005" shutdown="SHUTDOWN">#<Server port="8100" shutdown="SHUTDOWN">#g' ${JOB_HOME}/tomcat-${JOB_NAME}/conf/nf/server.xml &&  && \
    sed -i 's#<Connector port="8009" protocol="AJP/1.3"#<Connector port="8010" protocol="AJP/1.3"#g'
