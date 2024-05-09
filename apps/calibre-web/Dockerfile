FROM ghcr.io/cdloh/calibre-bare:7.10.0@sha256:53b896f7bf35bba5532b5413cd5ba84332c25be58b27b03e25e8a0cfa262ee45 as calibre

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

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
    apk add --no-cache \
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
    # Install required python packages
    && pip install --upgrade pip uv \
    && uv pip install --system --requirement /app/requirements.txt \
    && uv pip install --system --requirement /app/optional-requirements.txt \
    # Cleanup
    && apk del --purge .build-deps \
    && rm -rf \
    /root/.cache \
    /root/.cargo \
    /tmp/* \
    # Set permissions
    && chmod -R 755 /app

COPY --from=calibre / /opt/calibre
COPY ./apps/calibre-web/entrypoint.sh /entrypoint.sh

VOLUME [ "/config" ]
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/janeczku/calibre-web"