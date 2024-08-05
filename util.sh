
# loginfo <msg>
loginfo(){
    echo "[$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")] $@" 
}
# loginfo abc 123

# assert <msg> -- <cmd> <args...>
# assert <cmd> <args...>
assert(){
    set +e
    msg_arr=()
    sub_cmd=
    sub_args=()

    meet_delimiter=0
    for arg in "$@"; do
        if [ "$meet_delimiter" = "0" ] ;then
            # 没有遇到分割符号 --
            if [ "$arg" = "--" ] ;then
                meet_delimiter=1
            else
                msg_arr+=("$arg")
            fi
        elif [ "$meet_delimiter" = "1" ] ;then
            # 遇到过分割符后的第一个参数
            sub_cmd="$arg"
            meet_delimiter=2
        else
            sub_args+=("$arg")
        fi
    done
    if [ "$meet_delimiter" = "0" ] && [ ${#msg_arr[@]} -ne 0 ] ;then
        sub_cmd="${msg_arr[0]}"
        sub_args=("${msg_arr[@]:1}")
        msg_arr=()
    fi
    unset meet_delimiter arg
    # echo msg="${msg_arr[@]}" sub_cmd="$sub_cmd" sub_args="${sub_args[@]}"

    if [ -z "$sub_cmd" ] ;then
        echo "error: cmd param not found"
        echo "usage: assert <msg> -- <cmd> <args...>"
        echo "       assert <cmd> <args...>"
        return 1
    fi
    loginfo "--- will assert ${msg_arr[@]}: $sub_cmd ${sub_args[@]}"
    eval "$sub_cmd ${sub_args[@]}"
    if [ $? -eq 0 ] ;then
        loginfo "--- assert ok ${msg_arr[@]}: $sub_cmd ${sub_args[@]}"
        echo
    else
        loginfo "--- assert fail ${msg_arr[@]}: $sub_cmd ${sub_args[@]}"
        echo
        exit 1
    fi
}
# assert
# assert ls -l ~
# assert -- ls -l ~
# assert abc -- ls -l ~
# assert abc -- false


# assert_regex <grep-pattern> <msg> -- <cmd> <args...>
# assert_regex <grep-pattern> <cmd> <args...>
assert_regex(){
    grep_pattern="$1"
    shift
    assert "$@" "|" grep -E "$grep_pattern"
}
# assert_regex "dfadsfda" ls -l
# assert_regex "rw" ls -l ~


# assert_regex_invert <grep-pattern> <msg> -- <cmd> <args...>
# assert_regex_invert <grep-pattern> <cmd> <args...>
assert_regex_invert(){
    grep_pattern="$1"
    shift
    assert "$@" "|" grep -v -E "$grep_pattern"
}
