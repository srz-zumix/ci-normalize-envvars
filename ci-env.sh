#!/bin/sh
# ALL Environment Variables

# CUR_DIR=$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)
# . ${CUR_DIR}/parts/ci-env-git-commit.sh
# . ${CUR_DIR}/parts/ci-env-name.sh

ci_env_git_commit() {
    if [ -n "${CI_ENV_GIT_COMMIT+x}" ]; then
        return
    fi
    # AppVeyor
    if [ -n "${APPVEYOR_REPO_COMMIT+x}" ]; then
        export CI_ENV_GIT_COMMIT="${APPVEYOR_REPO_COMMIT}"
        return
    fi
    # Azure Pipelines
    if [ -n "${BUILD_SOURCEVERSION+x}" ]; then
        export CI_ENV_GIT_COMMIT="${BUILD_SOURCEVERSION}"
        return
    fi
    # Bitrise
    if [ -n "${BITRISE_CI_ENV_GIT_COMMIT+x}" ]; then
        export CI_ENV_GIT_COMMIT="${BITRISE_CI_ENV_GIT_COMMIT}"
        return
    fi
    # Buddy
    if [ -n "${BUDDY_EXECUTION_REVISION+x}" ]; then
        export CI_ENV_GIT_COMMIT="${BUDDY_EXECUTION_REVISION}"
        return
    fi
    # CircleCI
    if [ -n "${CIRCLE_SHA1+x}" ]; then
        export CI_ENV_GIT_COMMIT="${CIRCLE_SHA1}"
        return
    fi
    # Cirrus CI
    if [ -n "${CIRRUS_CHANGE_IN_REPO+x}" ]; then
        export CI_ENV_GIT_COMMIT="${CIRRUS_CHANGE_IN_REPO}"
        return
    fi
    # CodeFresh
    if [ -n "${CF_REVISION+x}" ]; then
        export CI_ENV_GIT_COMMIT="${CF_REVISION}"
        return
    fi
    # CodeShip
    if [ -n "${CI_COMMIT_ID+x}" ]; then
        export CI_ENV_GIT_COMMIT="${CI_COMMIT_ID}"
        return
    fi
    # Drone
    if [ -n "${DRONE_COMMIT_SHA+x}" ]; then
        export CI_ENV_GIT_COMMIT="${DRONE_COMMIT_SHA}"
        return
    fi
    # GitHub Actions
    if [ -n "${GITHUB_SHA+x}" ]; then
        export CI_ENV_GIT_COMMIT="${GITHUB_SHA}"
        return
    fi
    # Scrutinizer
    if [ -n "${SCRUTINIZER_SHA1+x}" ]; then
        export CI_ENV_GIT_COMMIT="${SCRUTINIZER_SHA1}"
        return
    fi
    # Semaphore
    if [ -n "${SEMAPHORE_GIT_SHA+x}" ]; then
        export CI_ENV_GIT_COMMIT="${SEMAPHORE_GIT_SHA}"
        return
    fi
    # Shippable
    if [ -n "${COMMIT+x}" ]; then
        export CI_ENV_GIT_COMMIT="${COMMIT}"
        return
    fi
    # Travis
    if [ -n "${TRAVIS_COMMIT+x}" ]; then
        export CI_ENV_GIT_COMMIT="${TRAVIS_COMMIT}"
        return
    fi
    # Wercker
    if [ -n "${WERCKER_CI_ENV_GIT_COMMIT+x}" ]; then
        export CI_ENV_GIT_COMMIT="${WERCKER_CI_ENV_GIT_COMMIT}"
        return
    fi
    # from git command
    if [ -z "${CI_ENV_GIT_COMMIT+x}" ]; then
        export CI_ENV_GIT_COMMIT=$(git rev-parse HEAD)
    fi
    # if [ -z "${CI_ENV_GIT_COMMIT+x}" ]; then
    #     export CI_ENV_CI_ENV_GIT_COMMIT=false
    # fi
}

ci_env_name() {
    if [ -n "${CI_ENV_NAME+x}" ]; then
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
    # export CI_ENV_NAME=$1
}

ci_env_git_commit
ci_env_name

export CI=true
