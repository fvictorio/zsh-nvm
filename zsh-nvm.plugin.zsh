export NVM_DIR="$HOME/.nvm"
IS_NVM_LOADED=false

loadnvm() {
  if [ $IS_NVM_LOADED = 'false' ]
  then
    . "$NVM_DIR/nvm.sh"
    IS_NVM_LOADED=true
  fi
}

loadnvm_hook() {
  local splitted=(${(@s/ /)2})
  local first=$splitted[1]
  if ! type "$first" > /dev/null; then
    loadnvm
  fi
}

load-nvmrc() {
  if [ -f .nvmrc ]; then
    loadnvm
    nvm use
  fi
}

add-zsh-hook chpwd load-nvmrc
add-zsh-hook preexec loadnvm_hook
load-nvmrc
