#!/bin/bash

set -e

printenv

env

#### ---- Make sure to provide Non-root user for launching Docker ----
#### ---- Default, we use base images's "developer"               ----

#### **** Allow non-root users to bind to use lower than 1000 ports **** ####
USE_CAP_NET_BIND=${USE_CAP_NET_BIND:-0}
if [ ${USE_CAP_NET_BIND} -gt 0 ]; then
    sudo setcap 'cap_net_bind_service=+ep' ${PRODUCT_EXE}
fi

#### ------------------------------------------------------------------------
#### 1.) Setup needed stuffs, e.g., init db etc. ....
#### (do something here for preparation)
#### ------------------------------------------------------------------------
echo "Add user nginx ..."
/bin/bash -c "/scripts/add-user-sudo.sh ${USER:-nginx}"

echo "Preparing Certificates ..."
echo "y" | /bin/bash -c "/scripts/create-ssl-certificate-default.sh"

sudo mkdir -p /var/lib/nginx /var/log/nginx /etc/nginx

sudo chown -R ${USER}:${USER} /var/lib/nginx /var/log/nginx /etc/nginx 

export NON_ROOT_USER=${USER-nginx}

#### ------------------------------------------------------------------------
#### 2.A) As Root User -- Choose this or 2.B --####
#### ---- Use this when running Root user ---- ####
#exec "$@"
/bin/bash -c "$@"

#### 2.B) As Non-Root User -- Choose this or 2.A  ---- #### 
#### ---- Use this when running Non-Root user ---- ####
#### ---- Use gosu (or su-exec) to drop to a non-root user
#exec gosu ${NON_ROOT_USER} "$@"
#### ------------------------------------------------------------------------


tail -f /dev/null
