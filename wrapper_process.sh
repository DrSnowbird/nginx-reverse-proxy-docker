#!/bin/bash

set -e

printenv

/bin/bash -c "${HOME}/create-ssl-certificate-nginx.sh"


tail -f /dev/null
