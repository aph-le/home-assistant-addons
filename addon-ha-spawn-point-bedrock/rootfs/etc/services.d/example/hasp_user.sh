#!/usr/bin/env bash
#!/usr/bin/with-contenv bashio

# ------------------------------------------------------------------------------
# Updates given server file with value from ha config
#
# Arguments:
#   $1 key in home assistant addon config
#   $2 bedrock server config file
# ------------------------------------------------------------------------------
function hasp::user() {
    local ha_config_file=${1}
    local mc_config_file=${2}

    if [[ ! -f "${ha_config_file}" ]]; then
        bashio::log.debug  "ha_config_file NOT FOUND!"
        return "${__BASHIO_EXIT_NOK}"
    fi

    # check if we need to update the allow list file
    if bashio::config.exists "allow_list" ; then
        if bashio::config.false "allow_list" ; then
            bashio::log.yellow "Use Allow User List: False"
            return "${__BASHIO_EXIT_OK}"
        fi
    else
        bashio::log.yellow "Allow User List: False"
        return "${__BASHIO_EXIT_OK}"
    fi

    # set username and xuid for the server
    bashio::log "Creating allow List"
    for mc_user in $(bashio::config 'allow_user|keys'); do
        username=$(bashio::config "allow_user[${mc_user}].name")
        xuid=$(bashio::config "allow_user[${mc_user}].xuid")
        bashio::log "Setting up user ${username} - ${xuid}"
    done
    # not optimzed yet to avoid unessarry writes
    jq -r .allow_user "${ha_config_file}" > "${mc_config_file}"
}

# ------------------------------------------------------------------------------
# Updates given server file with value from ha config
#
# Arguments:
#   $1 key in home assistant addon config
#   $2 bedrock server config file
# ------------------------------------------------------------------------------
function hasp::user.permissions() {
    local ha_config_file=${1}
    local mc_config_file=${2}

    if [[ ! -f "${ha_config_file}" ]]; then
        bashio::log.debug  "ha_config_file NOT FOUND!"
        return "${__BASHIO_EXIT_NOK}"
    fi

    if [[ ! -f "${mc_config_file}" ]]; then
        bashio::log.debug  "ha_config_file NOT FOUND!"
        return "${__BASHIO_EXIT_NOK}"
    fi

    # not optimzed yet to avoid unessarry writes
    jq -r .permissions_user "${ha_config_file}" > "${mc_config_file}"

}