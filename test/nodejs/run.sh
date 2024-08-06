#!/usr/bin/env bash
set -e


script_path=$(readlink -f $(dirname "$0"))
source $script_path/../../util.sh


clear(){
    loginfo "will clear test data"
}
trap clear EXIT


loginfo "=== start basic env ==="
assert ls -al ~/.npm/lib
assert_regex 'yarn' cat ~/.nvm/default-packages
assert_regex 'pnpm' cat ~/.nvm/default-packages
assert_regex 'node_modules/.bin' 'echo $PATH'
assert_regex ${PNPM_HOME:-fadsfsdfdasf} 'echo $PATH'
assert_regex .npm/bin 'echo $PATH'
assert ! test -z $FNM_NODE_DIST_MIRROR
assert_regex $HOME/.nvm 'echo $NVM_DIR'
assert_regex $HOME/.local/share/pnpm 'echo $PNPM_HOME'
assert_regex $HOME/.npm 'echo $npm_config_prefix'
assert "bash -c 'source ~/.bashrc && type fnm'"
assert which node
assert which npm
assert which npx
assert which nvm.sh
assert "bash -c 'source ~/.bashrc && type nvm'"
assert which pnpm
assert which pnpx
assert which yarn
assert which yarnpkg
assert 'test -e /cloudide/workspace/.cloudide/extensions/dbaeumer.vscode-eslint-*'
assert 'test -e /cloudide/workspace/.cloudide/extensions/vue.volar-*'
