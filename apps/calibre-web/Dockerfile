FROM docker.io/library/python:3.12-alpine

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1

ENV UMASK="0002" \
    TZ="Etc/UTC" \
    CALIBRE_DBPATH=/config

USER root
WORKDIR /app

#hadolint ignore=DL3018,DL3013,DL4006
RUN \
    apk add --no-cache \
        bash \
        ca-certificates \
        catatonit \
        curl \
        ghostscript \
        libldap \
        libmagic \
        libsasl \
        libxi \
        libxslt \
        tzdata \
    && \
    apk add --no-cache --virtual=.build-deps \
        build-base \
        libffi-dev \
        musl-dev \
        openldap-dev \
    && \
    mkdir -p /app \
    && curl -fsSL "https://github.com/janeczku/calibre-web/archive/${VERSION}.tar.gz" \
        | tar xzf - -C /app --strip-components=1 \
    && \
    pip install uv \
    && \
    uv pip install --system --requirement requirements.txt \
    && \
    uv pip install --system --requirement optional-requirements.txt \
    && \
    chown -R root:root /app \
    && chmod -R 755 /app \
    && apk del --purge .build-deps \
    && rm -rf \
        /root/.cache \
        /root/.cargo \
        /tmp/*

COPY ./apps/calibre-web/entrypoint.sh /entrypoint.sh

USER nobody:nogroup
WORKDIR /config
VOLUME [ "/config" ]

ENTRYPOINT ["/usr/bin/catatonit", "--"]
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/janeczku/calibre-web"
