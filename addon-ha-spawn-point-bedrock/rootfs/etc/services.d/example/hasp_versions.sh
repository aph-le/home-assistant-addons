#!/usr/bin/env bash
#!/usr/bin/with-contenv bashio

function hasp::version() {
    local input_version=${1}
    local download_link=""

    if [ "$input_version" = "LATEST" ]; then
        input_version="LATEST"
    else
        download_link=$(cat /usr/bin/download_versions.json | jq -r -c '.[] | select(.bedrock_version | contains('\"$input_version\"')) | .download ')
    fi
    echo "${download_link}"
}