#!/bin/bash

set -e

printenv

/bin/bash -c "echo 'y' | ${HOME}/create-ssl-certificate-nginx.sh"


tail -f /dev/null
