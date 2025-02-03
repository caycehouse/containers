#!/usr/bin/env bash
#shellcheck disable=SC2086,SC2034

if [[ ! -f "/config/config.yaml" ]]; then
    printf "Copying over default configuration ...\n"
    cp /app/config.yaml /config/config.yaml

    printf "Creating api keys ...\n"
    api_key=$(tr -dc 'a-z0-9' < /dev/urandom | fold -w 32 | head -n 1)
    flask_secret_key=$(tr -dc 'a-z0-9' < /dev/urandom | fold -w 32 | head -n 1)
    yq -i '.auth.apikey = env(api_key)' /config/config.yaml
    yq -i '.general.flask_secret_key = env(flask_secret_key)' /config/config.yaml
fi

[[ -n "${BAZARR__API_KEY}" ]] && yq -i '.auth.apikey = env(BAZARR__API_KEY)' /config/config.yaml

exec \
    /usr/local/bin/python \
        /app/bin/bazarr.py \
            --no-update \
            --config /config \
            --port ${BAZARR__PORT} \
            "$@"
