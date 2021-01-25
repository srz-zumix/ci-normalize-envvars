#!/bin/bash
# CI_ENV_NAME

if [ -n "${CI_ENV_NAME+x}" ]; then
    return
fi

if [ -n "${AC_APPCIRCLE}" ]; then
    export APPCIRCLE=true
    export CI_ENV_NAME="Appcircle"
    return
fi

if [ -n "${APPVEYOR+x}" ]; then
    export CI_ENV_NAME="AppVeyor"
    return
fi

if [ -n "${AZURE_HTTP_USER_AGENT+x}" ]; then
    export AZURE_PIPELINES=true
    export CI_ENV_NAME="Azure Pipelines"
    return
fi

if [ -n "${BITRISE_IO+x}" ]; then
    export CI_ENV_NAME="Bitrise"
    return
fi

if [ -n "${BUDDY+x}" ]; then
    export CI_ENV_NAME="Buddy"
    return
fi

if [ -n "${CIRCLECI+x}" ]; then
    export CI_ENV_NAME="CircleCI"
    return
fi

if [ -n "${CIRRUS_CI+x}" ]; then
    export CI_ENV_NAME="Cirrus CI"
    return
fi

if [ -n "${CF_BUILD_URL+x}" ]; then
    export CODEFRESH=true
    export CI_ENV_NAME="Codefresh"
    return
fi

if [ -n "${CI_NAME+x}" ]; then
    if [ ${CI_NAME} = "codeship" ]; then
        export CODESHIP=true
        export CI_ENV_NAME="CodeShip"
        return
    fi
fi

if [ -n "${DRONE+x}" ]; then
    export CI_ENV_NAME="Drone"
    return
fi

if [ -n "${GITHUB_ACTIONS+x}" ]; then
    export CI_ENV_NAME="GitHub Actions"
    return
fi

if [ -n "${BUILD_URL+x}" ]; then
    if echo ${BUILD_URL} | grep -q peakflow; then
        export PEAKFLOW=true
        export CI_ENV_NAME="Peakflow"
        return
    fi
fi

if [ -n "${CI+x}" ]; then
    if [ ${CI} = "razorops" ]; then
        export RAZOROPS=true
        export CI_ENV_NAME="Razorops"
        return
    fi
fi

if [ -n "${SCRUTINIZER+x}" ]; then
    export CI_ENV_NAME="Scrutinizer"
    return
fi

if [ -n "${SEMAPHORE+x}" ]; then
    export CI_ENV_NAME="Semaphore"
    return
fi

if [ -n "${SHIPPABLE+x}" ]; then
    export CI_ENV_NAME="Shippable"
    return
fi

if [ -n "${TRAVIS+x}" ]; then
    export CI_ENV_NAME="Travis CI"
    return
fi

if [ -n "${WERCKER_RUN_URL+x}" ]; then
    export WERCKER=true
    export CI_ENV_NAME="Wercker"
    return
fi


if [ -z "${CI+x}" ]; then
    export CI_ENV_NAME="local"
    return
fi
export CI_ENV_NAME=$1
