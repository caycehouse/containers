#!/usr/bin/env bash

if [ -n "${TALOS_NODE_IP}" ]; then
    TALOS_IMAGE_NAME="$(talosctl -n "${TALOS_NODE_IP}" read /system/state/config.yaml | yq '.machine.install.image' | sed 's@null@ghcr.io/siderolabs/installer@g' | sed 's@:.*@@g')"

    export TALOS_IMAGE_NAME
fi

echo "DEBUG: ${*/\$(TALOS_IMAGE_NAME)/${TALOS_IMAGE_NAME}}"

exec "${@/\$(TALOS_IMAGE_NAME)/${TALOS_IMAGE_NAME}}"
