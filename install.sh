main() {
  URL_PATH_TO_ENV_FILES="https://raw.githubusercontent.com/mikemartin1090/environmart/master"
  FILE=".environmart"
  curl -s "${URL_PATH_TO_ENV_FILES}/${FILE}" -o "${HOME}/${FILE}"
  ENVS=".zshrc"
  for env_file in $(echo $ENVS); do
    if ! grep "${FILE}" "${HOME}/${env_file}" > /dev/null; then
      echo Installing environmart into ${env_file}
      echo "source ${HOME}/${FILE}" >> "${HOME}/${env_file}"
    fi
  done
  echo All Done! Open a new window!
}

main
