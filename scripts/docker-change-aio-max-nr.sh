#!/bin/bash

docker run --rm -it --privileged ubuntu bash \
    -c "echo \"fs.aio-max-nr = 1048576\" >> /etc/sysctl.conf \
    && sysctl -p /etc/sysctl.conf"
