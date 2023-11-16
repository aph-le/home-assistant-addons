#!/usr/bin/env bash
#!/usr/bin/with-contenv bashio

# ------------------------------------------------------------------------------
# Updates given server file with value from ha config
#
# Arguments:
#   $1 key in home assistant addon config
#   $2 key in bedrock server config
#   $3 bedrock server config file
# ------------------------------------------------------------------------------
function hasp::config.update_server() {
    local ha_config_key=${1}
    local mc_config_key=${2}
    local mc_config_file=${3}

    local OLD_VALUE=""
    local NEW_VALUE=""

    OLD_VALUE=$(hasp::config._get_property "${mc_config_key}" "${mc_config_file}")
    bashio::log.green "Old Value ${OLD_VALUE}"

    if bashio::config.exists "${ha_config_key}" ; then
        NEW_VALUE="$(bashio::config "${ha_config_key}")"
        bashio::log.green "New Value ${NEW_VALUE}"

        hasp::config._set_property "${mc_config_key}" "$(bashio::config "${ha_config_key}")" "${mc_config_file}"
        bashio::log "Config: Update ${ha_config_key}"
    fi
}

# ------------------------------------------------------------------------------
# Replaces property value in given file.
#
# Arguments:
#   $1 key in file
#   $2 new value
#   $3 filename
# ------------------------------------------------------------------------------
function hasp::config._set_property() {
    if [ -z "$1" ]; then
        bashio::log.debug "No parameters provided, exiting..."
        exit 1
    fi
    if [ -z "$2" ]; then
        ashio::log.debug  "Key provided, but no value, breaking"
        exit 1
    fi
    if [ -z "$3" ]; then
        eashio::log.debug  "No file provided or setPropertyFile is not set, exiting..."
        exit 1
    fi

    if [ "$3" ] && [ ! -f "$3" ]; then
        eashio::log.debug  "File in command NOT FOUND!"
        exit 1
    fi

    file=$3
    # shellcheck disable=SC2002
    is_already_exist=$(cat "$file" | grep "$1" | cut -d'=' -f2)
    if [ "$is_already_exist" ]; then
        awk -v pat="^$1=" -v value="$1=$2" '{ if ($0 ~ pat) print value; else print $0; }' "$file" > "$file".tmp
    else
        cat $file > "$file".tmp
        echo "$1=$2" >> "$file".tmp
    fi
    mv "$file".tmp "$file"
}

# https://gist.github.com/adorogensky
function hasp::config._get_property() {
    property=$(sed -n "/^[ tab]*$1[ tab]*/p" $2)
    if [[ $property =~ ^([ tab]*"$1"[ tab]*=)(.*) ]]; then
        echo "${BASH_REMATCH[2]}"
    fi
}