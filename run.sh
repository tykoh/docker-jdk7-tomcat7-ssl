#!/bin/bash

VOLUME_HOME="/data"

if [[ ! -f /.machine.uuid ]]; then
	echo "=> First time running, preparing data."
	echo `uuid` > /.machine.uuid
	echo `cat /.machine.uuid`
fi

if [[ ! -d $VOLUME_HOME/html ]]; then
	echo "=> Going to create and link html folder"
	cp -R /var/www/html /data/
	mkdir -p /data/html && rm -fr /var/www/html && ln -s /data/html /var/www/html
else
    echo "=> Using an existing volume of html"
fi

if [[ ! -d $VOLUME_HOME/webapps ]]; then
	echo "=> Going to create and link webapps folder"
	mkdir -p /data/webapps
else
    echo "=> Using an existing volume of webapps"
fi

if [[ ! -d $VOLUME_HOME/logs ]]; then
	echo "=> Going to create and link logs folder"
	mkdir -p /data/logs
else
    echo "=> Using an existing volume of logs"
fi

if [[ ! -d $VOLUME_HOME/apache2 ]]; then
	echo "=> Going to link apache2 folder"

	mkdir -p /data/apache2 && cp -Rv /etc/apache2 /data/
else
    echo "=> Using an existing volume of html"
fi


/opt/tomcat/apache-tomcat-7.0.55/bin/startup.sh
echo "=> Started tomcat..."

exec supervisord -n
