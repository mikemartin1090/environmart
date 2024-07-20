#! /usr/bin/env bash

function _osType() {
  local _type="$1"
  echo "$OSTYPE" | grep "$_type" > /dev/null
}

function _commandExists() {
  local _cmd="$1"
  which "$_cmd" > /dev/null
}

main() {
  ENVIRONMART_LOAD_FILE=".environmart"
  if _osType linux \
    && _commandExists apt-get; then

    for _command in curl zsh git; do
      if ! _commandExists _command; then
        APPS_TO_INSTALL="$APPS_TO_INSTALL $_command"
      fi
    done

    if [ -n "$APPS_TO_INSTALL" ]; then
      [ "$EUID" -ne 0 ] && SUDO="sudo "
      eval "$SUDO apt-get update -y"
      eval "$SUDO apt-get install -y $APPS_TO_INSTALL"
    fi

  fi

  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi

  ##TODO: update this to master (or whatever branch I go with) when I'm done
  URL_PATH_TO_ENV_FILES="https://raw.githubusercontent.com/mikemartin1090/environmart/ubuntu-changes"
  if [ -f "./${ENVIRONMART_LOAD_FILE}" ]; then
    cp "./${ENVIRONMART_LOAD_FILE}" "${HOME}/${ENVIRONMART_LOAD_FILE}"
  else
    curl -s "${URL_PATH_TO_ENV_FILES}/${ENVIRONMART_LOAD_FILE}" -o "${HOME}/${ENVIRONMART_LOAD_FILE}"
  fi

  echo "Installing environmart into ${HOME}/.zshrc"
  echo "source ${ENVIRONMART_LOAD_FILE}" >> "${HOME}/.zshrc"
  echo All Done! Open a new window!
}

main
