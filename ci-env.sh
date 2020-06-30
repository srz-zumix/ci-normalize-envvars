#!/bin/bash
# ALL Environment Variables

# CUR_DIR=$(cd $(dirname $0) && pwd)
CUR_DIR=$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)

. ${CUR_DIR}/ci-env-git-commit.sh
. ${CUR_DIR}/ci-env-name.sh

export CI=true
