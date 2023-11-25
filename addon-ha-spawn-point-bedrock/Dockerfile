ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
    apt-get update -y
RUN \
    apt-get install python3 -y
RUN \
    apt-get install unzip -y

# Copy root filesystem
COPY rootfs /

# Corrects permissions for s6 v3
RUN if [ -d /etc/services.d ]; then chmod -R 755 /etc/services.d; fi && \
    if [ -d /etc/services.d/example ]; then chmod -R 755 /etc/services.d/example; fi && \
    if [ -f /etc/services.d/example/banner.sh ]; then chmod 755 /etc/services.d/example/banner.sh; fi


