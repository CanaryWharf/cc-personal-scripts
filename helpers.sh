CC_ID_REGEX='^[0-9]+$'
function syncToComputers() {
    for dir in $1/*/; do
        BASE=$(basename $dir)
        if [[ $BASE =~ $CC_ID_REGEX ]]
        then
            echo $dir
        fi
    done
}