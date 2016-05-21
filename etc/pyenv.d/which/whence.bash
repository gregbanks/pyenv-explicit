explicit_conf=$(dirname ${BASH_SOURCE[0]})/../../explicit.conf

if [ -f "$explicit_conf" ] && [ -n "$PYENV_COMMAND" ] && [ ! -x "$PYENV_COMMAND_PATH" ]; then
    . "$explicit_conf"
    cmd_version=$(eval echo "\$PYENV_EXPLICIT_${PYENV_COMMAND}")
    versions=($(pyenv-whence "${PYENV_COMMAND}" 2>/dev/null || true))
    if [ -n "${cmd_version}" ] && [ -n "${versions}" ]; then
        for version in ${versions[@]}; do
            if [ "$cmd_version" = "$version" ]; then
                PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${version}/bin/${PYENV_COMMAND}"
            fi
        done
    fi
fi
