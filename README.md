# docker-jdk7-tomcat7-ssl
Docker container with jdk7, tomcat7 and SSL.

A data volume is added such that any WAR files placed into the directory /data/webapps will be deployed automatically.

### Generate keystore to be used for SSL
```sh
keytool -genkey -alias tomcat -keyalg RSA -keypass password -storepass password -keystore .keystore
```
