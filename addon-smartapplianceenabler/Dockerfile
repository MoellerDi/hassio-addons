# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG \
    BUILD_ARCH \
    TEMPIO_VERSION \
    BASHIO_VERSION

RUN \
    set -x \
    && apt-get update && apt-get install -y --no-install-recommends \
    bash \
    jq \
    tzdata \
    curl \
    ca-certificates \
    xz-utils \
    \
    && curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}" \
    && chmod a+x /usr/bin/tempio \
    \
    && mkdir -p /usr/src/bashio \
    && curl -L -f -s "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" \
    | tar -xzf - --strip 1 -C /usr/src/bashio \
    && mv /usr/src/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/src/*

# Copy root filesystem
COPY rootfs /

CMD chmod +x /docker-run.sh && /docker-run.sh