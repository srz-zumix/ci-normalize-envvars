#!/bin/bash

CUR_DIR=$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)
OUTPUT="${CUR_DIR}/ci-env.sh"

{
    echo "#!/bin/bash"
    echo "# ALL Environment Variables"
    echo ""
} > "${OUTPUT}"

for file in $(find "${CUR_DIR}/parts" -name \*.sh -maxdepth 1 -type f | sort); do
    BASENAME=$(basename "${file}")
    echo "${BASENAME}"
    NAME="${BASENAME%%.sh}"
    {
        echo "${NAME}() {"
        sed -e "1d" "${file}"
        echo "}"
        echo "" 
    } >> "${OUTPUT}"
done

for file in $(find "${CUR_DIR}/parts" -name \*.sh -maxdepth 1 -type f | sort); do
    BASENAME=$(basename "${file}")
    NAME="${BASENAME%%.sh}"
    {
        echo "# shellcheck disable=SC2120"
        echo "${NAME}"
    } >> "${OUTPUT}" 
done

echo export CI=true >> "${OUTPUT}"
