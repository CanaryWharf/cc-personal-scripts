CC_ID_REGEX='^[0-9]+$'
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
function syncScripts() {
    cp -r "$SCRIPTPATH/lib" "$1"
}

function syncToComputers() {
    for dir in $1/*/; do
        BASE=$(basename "$dir")
        if [[ $BASE =~ $CC_ID_REGEX ]]
        then
            syncScripts "$dir"
        fi
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    syncToComputers "$@"
fi
