#!/bin/sh
# ALL Environment Variables

CUR_DIR=$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)

for file in `find . -name *.sh -maxdepth 1 -type f`; do
    . ${file}
done
