#ARG BASE_IMAGE=${BASE_IMAGE:-ubuntu:20}
ARG BASE_IMAGE=${BASE_IMAGE:-debian:stretch}
FROM ${BASE_IMAGE}

##############################################
#### ---- Installation Directories   ---- ####
##############################################
#ENV INSTALL_DIR=${INSTALL_DIR:-/usr}
ENV SCRIPT_DIR=${SCRIPT_DIR:-$INSTALL_DIR/scripts}

############################################
##### ---- System: certificates : ---- #####
##### ---- Corporate Proxy      : ---- #####
############################################
ENV LANG C.UTF-8
ARG LIB_BASIC_LIST="curl wget unzip ca-certificates"
RUN set -eux; \
    apt-get update -y && \
    apt-get install -y ${LIB_BASIC_LIST} 
    
COPY ./scripts ${SCRIPT_DIR}
COPY certificates /certificates
RUN ${SCRIPT_DIR}/setup_system_certificates.sh
RUN ${SCRIPT_DIR}/setup_system_proxy.sh

#################################################
#### ---- Installation: NGINX & dnsmasq ---- ####
#################################################
RUN apt-get update
RUN apt-get install -y nginx curl dnsmasq sudo gosu

#### ---- Volumes ---- ####
VOLUME /etc/nginx

#### ---- Scripts ---- ####
RUN apt-get install -y sudo gosu 

ENV USER=nginx
ENV HOME=/home/${USER}
ENV NON_ROOT_USER=${USER}

RUN echo "Add user nginx ..." && \
    groupadd ${USER} && sudo useradd ${USER} -m -d ${HOME} -s /bin/bash -g ${USER} 

#COPY ./scripts/create-ssl-certificate-default.sh /scripts
#COPY ./scripts/add-user.sh /scripts
#COPY ./scripts/add-user-sudo.sh /scripts
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
#RUN chmod +x /scripts/*.sh

RUN ls -al ${SCRIPT_DIR} /scripts

##############################
#### ---- Ports      ---- ####
##############################
#EXPOSE 38443 38080  39443 39999  33843 33030 

##############################
#### ---- Entrypoint ---- ####
##############################
ENTRYPOINT ["/docker-entrypoint.sh"]

# Add command
# CMD ["nginx", "-g", "daemon off;", "-c /etc/nginx/nginx.conf", "-t"]
CMD ["nginx", "-g", "daemon off;"]

#### ---- Debug only ---- ####
#CMD "/bin/bash"

#HEALTHCHECK CMD curl --fail http://localhost:28080 || exit 1
