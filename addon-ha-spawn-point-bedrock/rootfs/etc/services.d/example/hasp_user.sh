#!/usr/bin/env bash
#!/usr/bin/with-contenv bashio

function hasp::user() {
    local mc_config_file=${1}

    if [[ ! -f "${mc_config_file}" ]]; then
        bashio::log.debug  "ha_config_file NOT FOUND!"
        return "${__BASHIO_EXIT_NOK}"
    fi

    # Set username and password for the broker
    bashio::log "Creating allow List"
    for mc_user in $(bashio::config 'allow_user|keys'); do
        username=$(bashio::config "allow_user[${mc_user}].username")
        xuid=$(bashio::config "allow_user[${mc_user}].xuid")

        bashio::log "Setting up user ${username} - ${xuid}"
        #if ! bashio::config.true "logins[${login}].password_pre_hashed"
        #then
        #    password=$(pw -p "${password}")
        #else
        #    bashio::log.info "Using pre-hashed password for ${username}"
        #fi
        #echo "${username}:${password}" >> "${PW}"
        #echo "user ${username}" >> "${ACL}"
    done
}