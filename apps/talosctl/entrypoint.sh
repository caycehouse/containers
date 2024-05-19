#!/usr/bin/env bash

if [ -n "${NODE_IP}" ]; then
    TALOS_IMAGE_NAME="$(talosctl -n "${NODE_IP}" read /system/state/config.yaml | yq -r '.machine.install | select(.) | .image' | sed 's@:.*@@g')"

    export TALOS_IMAGE_NAME
fi

echo "DEBUG: ${*/\$(TALOS_IMAGE_NAME)/${TALOS_IMAGE_NAME}}"

exec "${@/\$(TALOS_IMAGE_NAME)/${TALOS_IMAGE_NAME}}"
