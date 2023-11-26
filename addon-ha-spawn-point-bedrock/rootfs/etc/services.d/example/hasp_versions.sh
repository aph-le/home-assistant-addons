#!/usr/bin/env bash

function hasp::version() {
    local input_version=${1}

    if [ "$input_version" = "LATEST" ]; then
        input_version="LATEST"
    fi

}