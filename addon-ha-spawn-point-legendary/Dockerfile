ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
    apt-get -y update -y \
    && apt-get -y install yq \
    && apt-get -y install unzip \
    && apt-get -y install openjdk-17-jre-headless

# Copy root filesystem
COPY rootfs /

# Copy defualt Configs
RUN mkdir /default_config
COPY /default_config/* /default_config/

# Corrects permissions for s6 v3
RUN if [ -d /etc/services.d ]; then chmod -R 755 /etc/services.d; fi && \
    if [ -d /etc/services.d/ha-spawn-point-bedrock ]; then chmod -R 755 /etc/services.d/ha-spawn-point-bedrock; fi && \
    if [ -f /etc/services.d/ha-spawn-point-bedrock/banner.sh ]; then chmod 755 /etc/services.d/ha-spawn-point-bedrock/banner.sh; fi

############
# 5 Labels #
############

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="aph-le (https://github.com/aph-le)" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="aph-le (https://github.com/aph-le)" \
    org.opencontainers.image.licenses="Apache" \
    org.opencontainers.image.url="https://github.com/aph-le" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
