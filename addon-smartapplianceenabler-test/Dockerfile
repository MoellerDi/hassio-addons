# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

ENV PATH="/usr/bin:${PATH}"
ENV JAVA_OPTS="-Duser.language=de -Duser.country=DE"
ENV SAE_INSTALL_DIR=/opt/sae
ENV SAE_HOME=/opt/sae/data
ENV SAE_VERSION=2.2.2

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
    && curl -L -f -s "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" | tar -xzf - --strip 1 -C /usr/src/bashio \
    && mv /usr/src/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/src/*

RUN echo "Europe/Berlin" > /etc/timezone
RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN mkdir -p $SAE_INSTALL_DIR \
    && curl -o $SAE_INSTALL_DIR/logback-spring.xml -L -k https://github.com/camueller/SmartApplianceEnabler/raw/master/run/logback-spring.xml \
    && curl -o $SAE_INSTALL_DIR/SmartApplianceEnabler-$SAE_VERSION.war -L -k https://github.com/camueller/SmartApplianceEnabler/releases/download/$SAE_VERSION/SmartApplianceEnabler-$SAE_VERSION.war

# Copy root filesystem
COPY rootfs /

CMD chmod +x /docker-run.sh && /docker-run.sh