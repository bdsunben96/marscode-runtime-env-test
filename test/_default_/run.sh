#!/usr/bin/env bash
set -e

script_path=$(readlink -f $(dirname "$0"))
source $script_path/../../util.sh

loginfo "=== start test _default_ ==="

loginfo "=== test file system ==="
assert touch /cloudide/workspace/.abc
assert touch /tmp/.abc
assert touch /cloudide/component/current/.abc
assert touch /cloudide/component/deamon/.abc
assert touch /cloudide/component/download/.abc
assert touch /cloudide/meta/.abc
assert touch /cloudide/compliance/.abc
assert touch /cloudide/socket/.abc
assert touch /cloudide/component/log/.abc
assert test -e /cloudide-cache/vscode-extensions
assert_regex_invert '^$' ls /cloudide-cache/vscode-extensions
assert_regex_invert '^$' ls /cloudide-cache/nix
# mkdir -p /tmp/empty
# assert_regex_invert '^$' ls /tmp/empty
assert test -e /home/cloudide-origin/.zshrc
assert test -e /etc/command-not-found.sh
assert test -e /etc/cloudide_profile
assert test -e /etc/shellIntegration-bash.sh
assert test -e /etc/shellIntegration-rc.zsh
assert ! touch /.abc
assert_regex_invert '^$' ls /nix/store
assert touch /nix/store/.abc
assert_regex_invert '^$' ls /nix/store/.abc
# assert_regex_invert '^$' ls /nix-store-upper


loginfo "=== test environment variables ==="
assert '[ "$CLOUDIDE_APISERVER_BASE_URL" = "https://bytesec.byteintlapi.com" ] || [ "$CLOUDIDE_APISERVER_BASE_URL" = "https://api-sg-central.marscode.com" ] || [ "$CLOUDIDE_APISERVER_BASE_URL" = "https://api-us-east.marscode.com" ] || [ "$CLOUDIDE_APISERVER_BASE_URL" = "https://bytesec.bytedance.com" ] || [ "$CLOUDIDE_APISERVER_BASE_URL" = "https://api.marscode.cn" ]'
assert '[ "$CLOUDIDE_APISERVER_USE_GATEWAY" = "true" ]'
assert '! [ -z "$CLOUDIDE_WORKSPACE_ID" ]'
assert '! [ -z "$CLOUDIDE_NAME" ]'
assert '[ "$CLOUDIDE_WORKSPACEPATH" = "/cloudide/workspace" ]'
assert '! [ -z "$CLOUDIDE_OPENEDPATH" ]'
assert '! [ -z "$AIRPOD_WS_TOKEN" ]'
assert '! [ -z "$AIRPOD_WSID" ]'
assert '! [ -z "$AIRPOD_WS_REGION" ]'
assert '! [ -z "$AIRPOD_WS_DC" ]'
assert '[ "$CLOUDIDE_PROVIDER_REGION" = "cn" ] || [ "$CLOUDIDE_PROVIDER_REGION" = "sg" ] || [ "$CLOUDIDE_PROVIDER_REGION" = "us" ]'
assert '[ "$CLOUDIDE_TENANT_NAME" = "public" ] '
assert '[ "$CLOUDIDE_IDE_SERVER_TYPE" = "icube_a0" ] '
assert '[ "$CLOUDIDE_CONTROL_PLANE" = "boe" ] || [ "$CLOUDIDE_CONTROL_PLANE" = "boei18n" ] || [ "$CLOUDIDE_CONTROL_PLANE" = "i18n" ] || [ "$CLOUDIDE_CONTROL_PLANE" = "sg" ] || [ "$CLOUDIDE_CONTROL_PLANE" = "cn" ]'
assert '[ "$CLOUDIDE_TENANT_ID" = "1dknw951n5p5vn" ] || [ "$CLOUDIDE_TENANT_ID" = "82g9meypogge2g" ]'
assert '! [ -z "$CLOUDIDE_PROJECT_ID" ]'
assert '[ "$CLOUDIDE_TEMPLATE" = "nix" ]'
# TODO
assert_regex '.local/state/nix/profiles/profile/lib/mariadb' 'echo $LIBRARY_PATH'
