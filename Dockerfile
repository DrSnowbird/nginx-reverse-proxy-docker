ARG BASE_IMAGE=debian:stretch
#FROM centos:7
#FROM openkbs/jdk-mvn-py3

FROM $BASE_IMAGE

#### ---- Installation: NGINX & dnsmasq ---- ####
RUN apt-get update
RUN apt-get install -y nginx curl dnsmasq

#### ---- Volumes ---- ####
VOLUME /etc/nginx

#### ---- Ports ---- ####
EXPOSE 8443 25901 26901 28080 

#### ---- Scripts ---- ####
RUN mkdir /scripts && apt-get install -y sudo gosu 

COPY ./scripts/create-ssl-certificate-default.sh /scripts
COPY ./scripts/add-user.sh /scripts
COPY ./scripts/add-user-sudo.sh /scripts
COPY ./docker-entrypoint.sh /scripts

ENV USER=nginx
ENV NON_ROOT_USER=${USER}

#### ---- Entrypoint ---- ####
ENTRYPOINT ["/scripts/docker-entrypoint.sh"]

# Add command
# CMD ["nginx", "-g", "daemon off;", "-c /etc/nginx/nginx.conf", "-t"]
CMD ["nginx", "-g", "daemon off;"]

#### ---- Debug only ---- ####
#CMD "/bin/bash"

#HEALTHCHECK CMD curl --fail http://localhost:28080 || exit 1
