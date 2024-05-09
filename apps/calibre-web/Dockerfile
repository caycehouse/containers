FROM docker.io/library/python:3.11-alpine

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
    CALIBRE_DBPATH=/config

USER root
WORKDIR /app

#hadolint ignore=DL3018,DL3013
RUN apk add --no-cache \
        bash \
        ca-certificates \
        ghostscript \
        libldap \
        libsasl \
        libxi \
        libxslt \
    && \
    apk add --no-cache --virtual=.build-deps \
        build-base \
        curl \
        libffi-dev \
        linux-headers \
        openldap-dev \
    && \
    # Download calibre-web release
    mkdir -p /app \
    && curl -fsSL https://github.com/janeczku/calibre-web/archive/${VERSION}.tar.gz \
    | tar xzf - -C /app --strip-components=1 \
    && \
    pip install --upgrade --requirement requirements.txt \
    pip install --upgrade --requirement optional-requirements.txt \
    && apk del --purge .build-deps \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && rm -rf \
        /root/.cache \
        /root/.cargo \
        /tmp/*

COPY ./apps/calibre-web/entrypoint.sh /entrypoint.sh
COPY --from=ghcr.io/cdloh/calibre-bare:7.10.0 / /opt/calibre

VOLUME [ "/config" ]
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/janeczku/calibre-web"
