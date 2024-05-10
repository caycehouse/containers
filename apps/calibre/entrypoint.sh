#!/usr/bin/env bash

if [[ "${CALIBRE_CREATE_LIBRARY}" == "true" && ! -f "${CALIBRE_LIBRARY}/metadata.db" ]]; then
    /app/calibredb --library-path="${CALIBRE_LIBRARY}" list
fi

exec \
    /app/calibre-server \
        --port=${CALIBRE_PORT} \
        --enable-auth \
        ${CALIBRE_LIBRARY} \
        "$@"
