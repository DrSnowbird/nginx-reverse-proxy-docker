#ARG BASE_IMAGE=${BASE_IMAGE:-ubuntu:20}
ARG BASE_IMAGE=${BASE_IMAGE:-debian:stretch}
FROM ${BASE_IMAGE}

#### ---- Installation: NGINX & dnsmasq ---- ####
RUN apt-get update
RUN apt-get install -y nginx curl dnsmasq

#### ---- Volumes ---- ####
VOLUME /etc/nginx

#### ---- Scripts ---- ####
RUN mkdir /scripts && apt-get install -y sudo gosu 

ENV USER=nginx
ENV HOME=/home/${USER}
ENV NON_ROOT_USER=${USER}

RUN echo "Add user nginx ..." && \
    groupadd ${USER} && sudo useradd ${USER} -m -d ${HOME} -s /bin/bash -g ${USER} 

COPY ./scripts/create-ssl-certificate-default.sh /scripts
COPY ./scripts/add-user.sh /scripts
COPY ./scripts/add-user-sudo.sh /scripts
COPY ./docker-entrypoint.sh /scripts
RUN chmod +x /scripts/*.sh

#### ---- Entrypoint ---- ####
ENTRYPOINT ["/scripts/docker-entrypoint.sh"]

# Add command
# CMD ["nginx", "-g", "daemon off;", "-c /etc/nginx/nginx.conf", "-t"]
CMD ["nginx", "-g", "daemon off;"]

#### ---- Ports ---- ####
#EXPOSE 8443 25901 26901 28080 

#### ---- Debug only ---- ####
#CMD "/bin/bash"

#HEALTHCHECK CMD curl --fail http://localhost:28080 || exit 1
