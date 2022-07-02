#!/bin/bash
# CI_ENV_NAME

detect_git_tag() {
    if [ -n "${CI_ENV_NAME+x}" ]; then
        return
    fi

    if [ -n "${AC_APPCIRCLE+x}" ]; then
        APPCIRCLE=true
        export APPCIRCLE
        CI_ENV_NAME="Appcircle"
        return
    fi

    if [ -n "${APPVEYOR+x}" ]; then
        CI_ENV_NAME="AppVeyor"
        return
    fi

    if [ -n "${AZURE_HTTP_USER_AGENT+x}" ]; then
        AZURE_PIPELINES=true
        export AZURE_PIPELINES
        CI_ENV_NAME="Azure Pipelines"
        return
    fi

    if [ -n "${BITRISE_IO+x}" ]; then
        CI_ENV_NAME="Bitrise"
        return
    fi

    if [ -n "${BUDDY+x}" ]; then
        CI_ENV_NAME="Buddy"
        return
    fi

    if [ -n "${CIRCLECI+x}" ]; then
        CI_ENV_NAME="CircleCI"
        return
    fi

    if [ -n "${CIRRUS_CI+x}" ]; then
        CI_ENV_NAME="Cirrus CI"
        return
    fi

    if [ -n "${CF_BUILD_URL+x}" ]; then
        CODEFRESH=true
        export CODEFRESH
        CI_ENV_NAME="Codefresh"
        return
    fi

    if [ -n "${CI_NAME+x}" ]; then
        if [ ${CI_NAME} = "codeship" ]; then
            CODESHIP=true
            export CODESHIP
            CI_ENV_NAME="CodeShip"
            return
        fi
    fi

    if [ -n "${DRONE+x}" ]; then
        CI_ENV_NAME="Drone"
        return
    fi

    if [ -n "${GITHUB_ACTIONS+x}" ]; then
        CI_ENV_NAME="GitHub Actions"
        return
    fi

    if [ -n "${JFROG_CLI_BUILD_NAME+x}" ]; then
        CI_ENV_NAME="JFrog Pipelines"
        return
    fi

    if [ -n "${BUILD_URL+x}" ]; then
        if echo ${BUILD_URL} | grep -q peakflow; then
            PEAKFLOW=true
            export PEAKFLOW
            CI_ENV_NAME="Peakflow"
            return
        fi
    fi

    if [ -n "${CI+x}" ]; then
        if [ ${CI} = "razorops" ]; then
            RAZOROPS=true
            export RAZOROPS
            CI_ENV_NAME="Razorops"
            return
        fi
    fi

    if [ -n "${SCRUTINIZER+x}" ]; then
        CI_ENV_NAME="Scrutinizer"
        return
    fi

    if [ -n "${SEMAPHORE+x}" ]; then
        CI_ENV_NAME="Semaphore"
        return
    fi

    if [ -n "${SHIPPABLE+x}" ]; then
        CI_ENV_NAME="Shippable"
        return
    fi

    if [ -n "${TRAVIS+x}" ]; then
        CI_ENV_NAME="Travis CI"
        return
    fi


    if [ -z "${CI+x}" ]; then
        CI_ENV_NAME="local"
        return
    fi
    CI_ENV_NAME="${1:-}"
}

detect_git_tag "$@"

export CI_ENV_NAME
