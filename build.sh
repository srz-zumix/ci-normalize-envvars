#!/bin/bash

CUR_DIR=$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)
OUTPUT=${CUR_DIR}/ci-env.sh

echo "#!/bin/bash" > ${OUTPUT}
echo "# ALL Environment Variables" >> ${OUTPUT}
echo "" >> ${OUTPUT}

for file in `find ${CUR_DIR}/parts -name \*.sh -maxdepth 1 -type f | sort`; do
    BASENAME=$(basename ${file})
    echo ${BASENAME}
    NAME=${BASENAME%%.sh}
    echo "${NAME}() {" >> ${OUTPUT}
    sed -e "1d" ${file} >> ${OUTPUT}
    echo "}" >> ${OUTPUT}
    echo "" >> ${OUTPUT}
done

for file in `find ${CUR_DIR}/parts -name \*.sh -maxdepth 1 -type f | sort`; do
    BASENAME=$(basename ${file})
    NAME=${BASENAME%%.sh}
    echo ${NAME} >> ${OUTPUT}    
done

echo export CI=true >> ${OUTPUT}
