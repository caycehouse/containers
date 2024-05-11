FROM node:lts-slim as spt

ARG TARGETPLATFORM
ARG VERSION

USER root
WORKDIR /tmp

# hadolint ignore=DL3008,DL3015,SC2039,SC2086
RUN \
    apt-get update \
    && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates \
    curl \
    git \
    git-lfs \
    && \
    case "${TARGETPLATFORM}" in \
    'linux/amd64') \
    export ARCH='x64'; \
    ;; \
    'linux/arm64') \
    export ARCH='arm64'; \
    ;; \
    esac \
    && \
    git clone --depth 1 --branch $VERSION https://dev.sp-tarkov.com/SPT-AKI/Server.git srv \
    && cd srv/project \
    && git checkout \
    && git-lfs pull \
    && npm install \
    && npm run build:release -- --arch="$ARCH" --platform=linux

# TODO: Switch this to alpine later.
FROM docker.io/library/ubuntu:24.04

COPY --from=spt /tmp/srv/project/build /opt/server

CMD ["/opt/server/Aki.Server.exe"]
