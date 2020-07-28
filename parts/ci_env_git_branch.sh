#!/bin/bash
# CI_ENV_GIT_BRANCH
# CI_ENV_GIT_BASE_BRANCH
# CI_ENV_GIT_SOURCE_BRANCH: provide only if pull request. (equal to CI_ENV_GIT_BRANCH)
# CI_ENV_GIT_TARGET_BRANCH: provide only if pull request. (equal to CI_ENV_GIT_BASE_BRANCH)


# AppVeyor
if [ -n "${APPVEYOR_REPO_BRANCH+x}" ]; then
    if [ -n "${APPVEYOR_PULL_REQUEST_HEAD_REPO_BRANCH+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${APPVEYOR_PULL_REQUEST_HEAD_REPO_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${APPVEYOR_REPO_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${APPVEYOR_PULL_REQUEST_HEAD_REPO_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${APPVEYOR_REPO_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${APPVEYOR_REPO_BRANCH}"
    fi
    return
fi

# AzurePipelines
if [ -n "${BUILD_SOURCEBRANCH+x}" ]; then
    if [ -n "${SYSTEM_PULLREQUEST_TARGETBRANCH+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH=$(echo ${SYSTEM_PULLREQUEST_SOURCEBRANCH} | sed -e s@refs/.*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH=$(echo ${SYSTEM_PULLREQUEST_TARGETBRANCH} | sed -e s@refs/.*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
    else
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH=$(echo ${BUILD_SOURCEBRANCH} | sed -e s@refs/.*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH=$(echo ${BUILD_SOURCEBRANCH} | sed -e s@refs/.*/@@g)
        fi
    fi
    return
fi

# Bitrise
if [ -n "${BITRISE_GIT_BRANCH+x}" ]; then
    if [ -n "${BITRISE_GIT_BRANCH_DEST+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${BITRISE_GIT_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${BITRISE_GIT_BRANCH_DEST}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${BITRISE_GIT_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${BITRISE_GIT_BRANCH}"
    fi
    return
fi

# Buddy
if [ -n "${BUDDY_EXECUTION_BRANCH+x}" ]; then
    if [ -n "${BUDDY_EXECUTION_PULL_REQUEST_HEAD_BRANCH+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${BUDDY_EXECUTION_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${BUDDY_EXECUTION_PULL_REQUEST_HEAD_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${BUDDY_EXECUTION_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${BUDDY_EXECUTION_BRANCH}"
    fi
    return
fi

# CircleCI
if [ -n "${CIRCLE_BRANCH+x}" ]; then
    if [ -n "${CIRCLE_PULL_REQUEST+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${CIRCLE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${CIRCLE_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${CIRCLE_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${CIRCLE_BRANCH}"
    fi
    return
fi

# Cirrus CI
if [ -n "${CIRRUS_BRANCH+x}" ]; then
    if [ -n "${CIRRUS_BASE_BRANCH+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${CIRRUS_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${CIRRUS_BASE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${CIRRUS_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${CIRRUS_BRANCH}"
    fi
    return
fi

# Codefresh
if [ -n "${CF_BRANCH+x}" ]; then
    if [ -n "${CF_PULL_REQUEST_TARGET+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${CF_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${CF_PULL_REQUEST_TARGET}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${CF_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${CF_BRANCH}"
    fi
    return
fi

# CodeShip
if [ -n "${CI_BRANCH+x}" ]; then
    if [ -n "${CI_PULL_REQUEST+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${CI_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${CI_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${CI_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${CI_BRANCH}"
    fi
    return
fi

# Drone
if [ -n "${DRONE_BRANCH+x}" ]; then
    if [ -n "${DRONE_TARGET_BRANCH+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${DRONE_SOURCE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${DRONE_TARGET_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
    else
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${DRONE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${DRONE_BRANCH}"
        fi
    fi
    return
fi

# GitHub Actions
if [ -n "${GITHUB_REF+x}" ]; then
    if [ -n "${GITHUB_BASE_REF+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH=$(echo ${GITHUB_HEAD_REF} | sed -e s@refs/.*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH=$(echo ${GITHUB_BASE_REF} | sed -e s@refs/.*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
    else
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH=$(echo ${GITHUB_REF} | sed -e s@refs/.*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH=$(echo ${GITHUB_REF} | sed -e s@refs/.*/@@g)
        fi
    fi
    return
fi

# Scrutinizer
if [ -n "${SCRUTINIZER_BRANCH+x}" ]; then
    if [ -n "${SCRUTINIZER_PR_SOURCE_BRANCH+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${SCRUTINIZER_PR_SOURCE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${SCRUTINIZER_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${SCRUTINIZER_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${SCRUTINIZER_BRANCH}"
    fi
    return
fi

# Semaphore
if [ -n "${SEMAPHORE_GIT_BRANCH+x}" ]; then
    if [ -n "${SEMAPHORE_GIT_PR_BRANCH+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${SEMAPHORE_GIT_PR_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${SEMAPHORE_GIT_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${SEMAPHORE_GIT_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${SEMAPHORE_GIT_BRANCH}"
    fi
    return
fi

# Shippable
if [ -n "${BRANCH+x}" ]; then
    if [ -n "${BASE_BRANCH+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${BASE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${BRANCH}"
    fi
    return
fi

# Peakflow

# RazorOps
if [ -n "${CI_REPO_BRANCH+x}" ]; then
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${CI_REPO_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${CI_REPO_BRANCH}"
    fi
    return
fi

# Travis CI
if [ -n "${TRAVIS_BRANCH+x}" ]; then
    if [ -n "${TRAVIS_PULL_REQUEST_BRANCH}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${TRAVIS_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${TRAVIS_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${TRAVIS_BRANCH}"
    fi
    return
fi

# Wercker
if [ -n "${WERCKER_GIT_BRANCH+x}" ]; then
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${WERCKER_GIT_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${WERCKER_GIT_BRANCH}"
    fi
    return
fi
