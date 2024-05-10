FROM docker.io/library/ubuntu:24.04

ARG TARGETPLATFORM
ARG VERSION

ENV CALIBRE_CREATE_LIBRARY="true" \
    CALIBRE_LIBRARY="/config" \
    CALIBRE_PORT="8080"

ENV UMASK="0002" \
    TZ="Etc/UTC"

USER root
WORKDIR /app

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
    apt-get update \
    && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        catatonit \
        libegl1 \
        libfontconfig1 \
        libopengl0 \
        libxdamage1 \
        libxkbcommon0 \
        python3 \
        xz-utils \
    && \
    case "${TARGETPLATFORM}" in \
        'linux/amd64') \
            export ARCH='x86_64'; \
        ;; \
        'linux/arm64') \
            export ARCH='arm64'; \
        ;; \
    esac \
    && \
    mkdir -p /opt/calibre \
    && \
    curl -fsSL "https://download.calibre-ebook.com/${VERSION}/calibre-${VERSION}-${ARCH}.txz" \
        | tar Jxvf - -C /app \
    && /app/calibre_postinstall \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get clean \
    && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/

COPY ./apps/calibre/entrypoint.sh /entrypoint.sh

USER nobody:nogroup
WORKDIR /config
VOLUME [ "/config" ]

ENTRYPOINT ["/usr/bin/catatonit", "--"]
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/kovidgoyal/calibre"
