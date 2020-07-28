#!/bin/bash
# ALL Environment Variables

CUR_DIR=$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)

for file in `find ${CUR_DIR} -name \*.sh -maxdepth 1 -type f`; do
    . ${file}
done
