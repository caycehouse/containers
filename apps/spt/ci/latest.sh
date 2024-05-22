#!/usr/bin/env bash
version=$(curl -sX GET "https://dev.sp-tarkov.com/api/v1/repos/SPT/Server/tags" | jq --raw-output '.[0].name' 2>/dev/null)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
