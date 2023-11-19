#!/usr/bin/env bash
#!/usr/bin/with-contenv bashio


function hasp::config() {
    local ha_config_file=${1}
    local mc_config_file=${2}
    local ha_config_entries=()

    if [[ ! -f "${ha_config_file}" ]]; then
        bashio::log.debug  "ha_config_file NOT FOUND!"
        return "${__BASHIO_EXIT_NOK}"
    fi

    if [[ ! -f "${mc_config_file}" ]]; then
        bashio::log.debug  "ha_config_file NOT FOUND!"
        return "${__BASHIO_EXIT_NOK}"
    fi

    mapfile -t ha_config_entries < <(jq -r 'keys[]' "${ha_config_file}")

    bashio::log.red "HA CONFIG ENTRIES"
    bashio::log.red "${ha_config_entries[@]}"

    for ha_key in "${ha_config_entries[@]}"
    do
        bashio::log.red "${ha_key}"
        #replace undercsored with dashes
        mc_key=${ha_key//_/-}
        if hasp::config._test_property "${mc_key}" "${mc_config_file}"; then
            bashio::log.red "${mc_key}"
        fi
        # or do whatever with individual element of the array
    done

}

# ------------------------------------------------------------------------------
# Updates given server file with value from ha config
#
# Arguments:
#   $1 key in home assistant addon config
#   $2 bedrock server config file
# ------------------------------------------------------------------------------
function hasp::config.update_server() {
    local ha_config_key=${1}
    local mc_config_key=
    local mc_config_file=${2}

    local OLD_VALUE=""
    local NEW_VALUE=""

    #replace undercsored with dashes
    mc_config_key=${ha_config_key//_/-}

    OLD_VALUE=$(hasp::config._get_property "${mc_config_key}" "${mc_config_file}")

    if bashio::config.exists "${ha_config_key}" ; then
        NEW_VALUE="$(bashio::config "${ha_config_key}")"

        if [ ! "${OLD_VALUE}" == "${NEW_VALUE}" ] ; then
            bashio::log.green "Config: update server entry: ${mc_config_key} = ${NEW_VALUE}"
            hasp::config._set_property "${mc_config_key}" "$(bashio::config "${ha_config_key}")" "${mc_config_file}"
        fi
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
        bashio::log.debug  "Key provided, but no value, breaking"
        exit 1
    fi
    if [ -z "$3" ]; then
        bashio::log.debug  "No file provided or setPropertyFile is not set, exiting..."
        exit 1
    fi

    if [ "$3" ] && [ ! -f "$3" ]; then
        bashio::log.debug  "File in command NOT FOUND!"
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

# ------------------------------------------------------------------------------
# Tests if property exits in given file.
#
# Arguments:
#   $1 key in file
#   $2 filename
# ------------------------------------------------------------------------------
function hasp::config._test_property() {
    property=$(sed -n "/^[ tab]*$1[ tab]*/p" $2)
    if [[ $property =~ ^([ tab]*"$1"[ tab]*=)(.*) ]]; then
        return "${__BASHIO_EXIT_OK}"
    fi

    return "${__BASHIO_EXIT_NOK}"
}