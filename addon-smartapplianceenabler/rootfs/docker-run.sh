#!/usr/bin/env bashio

bashio::log.info "Preparing to start SmartApplianceEnabler..."

SAE_HOME=/config/SmartApplianceEnabler
bashio::log.info "... SAE_HOME = ${SAE_HOME}"

if [[ ! -e $SAE_HOME ]]; then
    mkdir $SAE_HOME
elif [[ ! -d $SAE_HOME ]]; then
    echo "$SAE_HOME already exists but is not a directory"
    exit 1
fi

SAE_PORT=$(bashio::config 'sae_www_port')
JAVA_OPTS="${JAVA_OPTS} -Dserver.port=${SAE_PORT}"
bashio::log.info "... JAVA_OPTS = ${JAVA_OPTS}"

exec java $JAVA_OPTS \
            -Djava.awt.headless=true \
            -Xmx256m -Dsae.home=$SAE_HOME \
            -Dlogging.config=$SAE_INSTALL_DIR/logback-spring.xml \
            -jar $SAE_INSTALL_DIR/SmartApplianceEnabler-$SAE_VERSION.war
