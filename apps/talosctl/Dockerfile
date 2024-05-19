FROM docker.io/library/alpine:3.19

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

#hadolint ignore=DL3018
RUN apk add --no-cache bash curl yq \
    && curl -sL -o /usr/bin/talosctl https://github.com/siderolabs/talos/releases/download/v${VERSION}/talosctl-linux-amd64 \
    && chmod +x /usr/bin/talosctl

COPY --chmod=0755 --chown=65000:65000 entrypoint.sh /usr/local/bin/entrypoint.sh

USER 65000:65000
VOLUME ["/tmp"]
ENTRYPOINT ["/usr/local/bin/base-entrypoint.sh", "/usr/local/bin/entrypoint.sh", "/usr/bin/talosctl"]

LABEL org.opencontainers.image.source="https://github.com/siderolabs/talos/"
