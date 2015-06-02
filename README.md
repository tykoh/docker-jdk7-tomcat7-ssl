# docker-jdk7-tomcat7-ssl
Docker container with jdk7, tomcat7 and SSL.

A data volume is added such that any WAR files placed into the directory /data/webapps will be deployed automatically.

### Generate keystore to be used for SSL
```sh
keytool -genkey -alias tomcat -keyalg RSA \
  -keypass password -storepass password -keystore .keystore
```

### Build docker image
```sh
docker build --tag=jdk7-tomcat7-ssl .
```

### Run docker container
```sh
docker run -d -p 80:80 -p 443:443 jdk7-tomcat7-ssl
```
