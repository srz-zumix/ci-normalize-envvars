#!/bin/sh
# CI_ENV_GIT_COMMIT

if [ -n "${CI_ENV_GIT_COMMIT+x}" ]; then
    return
fi

if [ -n "${APPVEYOR_REPO_COMMIT+x}" ]; then
    export CI_ENV_GIT_COMMIT="${APPVEYOR_REPO_COMMIT}"
    return
fi

if [ -n "${BUILD_SOURCEVERSION+x}" ]; then
    export CI_ENV_GIT_COMMIT="${BUILD_SOURCEVERSION}"
    return
fi

if [ -n "${BITRISE_CI_ENV_GIT_COMMIT+x}" ]; then
    export CI_ENV_GIT_COMMIT="${BITRISE_CI_ENV_GIT_COMMIT}"
    return
fi

if [ -n "${BUDDY_EXECUTION_REVISION+x}" ]; then
    export CI_ENV_GIT_COMMIT="${BUDDY_EXECUTION_REVISION}"
    return
fi

if [ -n "${CIRCLE_SHA1+x}" ]; then
    export CI_ENV_GIT_COMMIT="${CIRCLE_SHA1}"
    return
fi

if [ -n "${CIRRUS_CHANGE_IN_REPO+x}" ]; then
    export CI_ENV_GIT_COMMIT="${CIRRUS_CHANGE_IN_REPO}"
    return
fi

if [ -n "${CF_REVISION+x}" ]; then
    export CI_ENV_GIT_COMMIT="${CF_REVISION}"
    return
fi

if [ -n "${CI_COMMIT_ID+x}" ]; then
    export CI_ENV_GIT_COMMIT="${CI_COMMIT_ID}"
    return
fi

if [ -n "${DRONE_COMMIT_SHA+x}" ]; then
    export CI_ENV_GIT_COMMIT="${DRONE_COMMIT_SHA}"
    return
fi

if [ -n "${GITHUB_SHA+x}" ]; then
    export CI_ENV_GIT_COMMIT="${GITHUB_SHA}"
    return
fi

if [ -n "${SCRUTINIZER_SHA1+x}" ]; then
    export CI_ENV_GIT_COMMIT="${SCRUTINIZER_SHA1}"
    return
fi

if [ -n "${SEMAPHORE_GIT_SHA+x}" ]; then
    export CI_ENV_GIT_COMMIT="${SEMAPHORE_GIT_SHA}"
    return
fi

if [ -n "${COMMIT+x}" ]; then
    export CI_ENV_GIT_COMMIT="${COMMIT}"
    return
fi

if [ -n "${TRAVIS_COMMIT+x}" ]; then
    export CI_ENV_GIT_COMMIT="${TRAVIS_COMMIT}"
    return
fi

if [ -n "${WERCKER_CI_ENV_GIT_COMMIT+x}" ]; then
    export CI_ENV_GIT_COMMIT="${WERCKER_CI_ENV_GIT_COMMIT}"
    return
fi


if [ -z "${CI_ENV_GIT_COMMIT+x}" ]; then
    export CI_ENV_GIT_COMMIT=$(git rev-parse HEAD)
fi
if [ -z "${CI_ENV_GIT_COMMIT+x}" ]; then
    export CI_ENV_CI_ENV_GIT_COMMIT=$1
fi
