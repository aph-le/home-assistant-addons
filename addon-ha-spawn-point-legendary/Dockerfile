ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG PAPERMC_VERSION="1.20.4"
ARG PAPERMC_BUILD="361"
ARG JAVA_VERSION="openjdk-17-jre-headless"

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
    apt-get -y update -y \
    && apt-get -y install yq \
    && apt-get -y install unzip \
    && apt-get -y install $JAVA_VERSION

# Copy root filesystem
COPY rootfs /

# Copy defualt Configs
RUN mkdir /default_config
COPY default_config/* /default_config/

# Corrects permissions for s6 v3
RUN if [ -d /etc/services.d ]; then chmod -R 755 /etc/services.d; fi && \
    if [ -d /etc/services.d/ha-spawn-point-legendary ]; then chmod -R 755 /etc/services.d/ha-spawn-point-legendary; fi

# Get needed binaries
RUN mkdir -p minecraft/plugins
# PaperMC
RUN curl --no-progress-meter -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4.212 Safari/537.36" -o /minecraft/papermc.jar "https://api.papermc.io/v2/projects/paper/versions/$PAPERMC_VERSION/builds/$PAPERMC_BUILD/downloads/paper-$PAPERMC_VERSION-$PAPERMC_BUILD.jar"
# Floodgate
RUN curl --no-progress-meter -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4.212 Safari/537.36" -o /minecraft/plugins/Floodgate-Spigot.jar "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"
# Geyser
RUN curl --no-progress-meter -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4.212 Safari/537.36" -o /minecraft/plugins/Geyser-Spigot.jar "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"

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
