# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

# Copy root filesystem
COPY rootfs /

# Corrects permissions for s6 v3
RUN if [ -d /etc/services.d ]; then chmod -R 755 /etc/services.d; fi && \
    if [ -d /etc/services.d/example ]; then chmod -R 755 /etc/services.d/example; fi && \
    if [ -f /etc/services.d/example/banner.sh ]; then chmod 755 /etc/services.d/example/banner.sh; fi
