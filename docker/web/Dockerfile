#examstack docker

FROM ubuntu:14.04

MAINTAINER linxuhua hualee215@gmail.com

LABEL name="examstack portal"
LABEL vendor="Ocelot & Scar"
LABEL license=GPLv2

ADD http://mirror.bit.edu.cn/apache/tomcat/tomcat-8/v8.5.4/bin/apache-tomcat-8.5.4.tar.gz /opt/

COPY Portal-2.0.0      /opt/apache-tomcat-8.5.4/webapps/Portal
COPY Management-2.0.0      /opt/apache-tomcat-8.5.4/webapps/Management
COPY config.sh  /opt/config.sh
