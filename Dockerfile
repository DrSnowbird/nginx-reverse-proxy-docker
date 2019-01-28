#FROM debian:stretch
#FROM centos:7
FROM openkbs/jdk-mvn-py3

# Installation: NGINX & dnsmasq
RUN apt-get update
RUN apt-get install -y nginx curl dnsmasq

# Volumes
VOLUME /etc/nginx
#VOLUME /etc/nginx/ssl
#VOLUME /etc/nginx/sites-enabled
#VOLUME /etc/nginx/certificates
#VOLUME /etc/nginx/conf.d

# Copie des fichiers de configuration
#COPY confs /etc/nginx/

#RUN mkdir -p /etc/nginx
#COPY ./etc/nginx/nginx.conf /etc/nginx/nginx.conf

#COPY confs/conf.d/proxy.conf /etc/nginx/conf.d/

# Ports
EXPOSE 28080 26901 25901

# Add command
# CMD ["nginx", "-g", "daemon off;", "-c /etc/nginx/nginx.conf", "-t"]
CMD ["nginx", "-g", "daemon off;"]
#CMD "/bin/bash"

#HEALTHCHECK CMD curl --fail http://localhost:28080 || exit 1
