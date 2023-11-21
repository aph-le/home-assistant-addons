#!/usr/bin/env bash
#!/usr/bin/with-contenv bashio

function hasp::user() {
    local mc_config_file=${1}

    if [[ ! -f "${mc_config_file}" ]]; then
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

    # Set username and xuid for the server
    bashio::log "Creating allow List"
    for mc_user in $(bashio::config 'allow_user|keys'); do
        username=$(bashio::config "allow_user[${mc_user}].username")
        xuid=$(bashio::config "allow_user[${mc_user}].xuid")

        bashio::log "Setting up user ${username} - ${xuid}"
    done
}