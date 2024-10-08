#!/usr/bin/env bash
#shellcheck disable=SC2086

if [ -f "${CALIBRE_DBPATH}/calibre-web.log" ]; then
  rm "${CALIBRE_DBPATH}/calibre-web.log"
fi

ln -s /dev/stdout "${CALIBRE_DBPATH}/calibre-web.log"

exec \
  python3  \
    /app/cps.py \
    "$@"
