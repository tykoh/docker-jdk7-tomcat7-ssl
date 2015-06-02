FROM ubuntu:latest
MAINTAINER TYKOH <tzeyong [at] gmail {dot} com >
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen $LANG; echo "LANG=\"${LANG}\"" > /etc/default/locale; dpkg-reconfigure locales
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install git
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install openjdk-7-jre-headless wget unzip vim
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install apache2 libapache2-mod-jk
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install supervisor

RUN mkdir -p /opt/tomcat
RUN cd /opt/tomcat
# note docker will auto extract tar gz files
ADD apache-tomcat-7.0.55/ /opt/tomcat/apache-tomcat-7.0.55

# Add volumes for data
VOLUME  ["/data"]


# Add supervisord stuff
ADD start-apache2.sh /start-apache2.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf

# add self sign cert for apache2
ADD .keystore /opt/tomcat/.keystore

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
## prepare apache2 ssl
RUN a2enmod ssl
## RUN a2ensite default-ssl
RUN a2enmod jk

ADD workers.properties /etc/libapache2-mod-jk/workers.properties

ADD .keystore /opt/tomcat/.keystore
## ADD default-ssl /etc/apache2/sites-available/default-ssl.conf

EXPOSE 80 443
CMD ["/run.sh"]
