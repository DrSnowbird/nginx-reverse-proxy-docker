#!/bin/bash

##################################
## ---- user: developer ----
##################################

USER=${1:-developer}
HOME=/home/${USER}

sudo groupadd ${USER} && sudo useradd ${USER} -m -d ${HOME} -s /bin/bash -g ${USER} 
#echo "${USER} ALL=NOPASSWD:ALL" | sudo tee -a /etc/sudoers

sudo usermod -aG sudo ${USER}


