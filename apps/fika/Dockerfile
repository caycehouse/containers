FROM node:lts-slim as fika

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV DEBCONF_NONINTERACTIVE_SEEN="true" \
    DEBIAN_FRONTEND="noninteractive" \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE="DontWarn"

ENV UMASK="0002" \
    TZ="Etc/UTC"

USER root
WORKDIR /opt/server

COPY --from=ghcr.io/caycehouse/spt:3.8.1 /opt/server .

# hadolint ignore=DL3008,DL3015,SC2039,SC2086
RUN \
    apt-get update \
    && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates \
    catatonit \
    curl \
    git \
    && \
    case "${TARGETPLATFORM}" in \
    'linux/amd64') \
    export ARCH='amd64'; \
    ;; \
    'linux/arm64') \
    export ARCH='arm64'; \
    ;; \
    esac \
    && \
    git clone --depth 1 --branch "v$VERSION" https://github.com/project-fika/Fika-Server.git ./user/mods/fika-server \
    && cd user/mods/fika-server \
    && git checkout \
    && npm install \
    && rm -rf .git \
    && chmod -R 755 /opt/server \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get clean \
    && \
    rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/

COPY ./apps/fika/entrypoint.sh /entrypoint.sh

USER nobody:nogroup
WORKDIR /opt/server
VOLUME ["/opt/server"]

ENTRYPOINT [ "/usr/bin/catatonit", "--" ]
CMD ["/entrypoint.sh"]
