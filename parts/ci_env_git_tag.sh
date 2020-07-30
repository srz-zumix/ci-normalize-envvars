#!/bin/bash
# CI_ENV_GIT_TAG
# CI_ENV_GIT_TAG_NAME

if [ -n "${CI_ENV_GIT_TAG+x}" ]; then
    if [ -n "${CI_ENV_GIT_TAG_NAME+x}" ]; then
        return
    fi
fi

if [ -n "${APPVEYOR+x}" ]; then
    if [ -n "${APPVEYOR_REPO_TAG_NAME+x}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${APPVEYOR_REPO_TAG_NAME}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${AZURE_HTTP_USER_AGENT+x}" ]; then
    if echo ${BUILD_SOURCEBRANCH} | grep -q refs/tags/; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME=$(echo ${BUILD_SOURCEBRANCH} | sed -e s@refs/.*/@@g)
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${BITRISE_IO+x}" ]; then
    if [ -n "${BITRISE_GIT_TAG+x}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${BITRISE_GIT_TAG}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${BUDDY+x}" ]; then
    if [ -n "${BUDDY_EXECUTION_TAG+x}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${BUDDY_EXECUTION_TAG}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${CIRCLECI+x}" ]; then
    if [ -n "${CIRCLE_TAG+x}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${CIRCLE_TAG}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${CIRRUS_CI+x}" ]; then
    if [ -n "${CIRRUS_TAG+x}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${CIRRUS_TAG}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${CF_BUILD_URL+x}" ]; then
    # if [ -n "${CIRRUS_TAG+x}" ]; then
    #     export CI_ENV_GIT_TAG=true
    #     export CI_ENV_GIT_TAG_NAME="${CIRRUS_TAG}"
    # else
        export CI_ENV_GIT_TAG=false
    # fi
    return
fi

if [ -n "${CI_NAME+x}" ]; then
    if [ ${CI_NAME} = "codeship" ]; then
        # if [ -n "${CIRRUS_TAG+x}" ]; then
        #     export CI_ENV_GIT_TAG=true
        #     export CI_ENV_GIT_TAG_NAME="${CIRRUS_TAG}"
        # else
            export CI_ENV_GIT_TAG=false
        # fi
        return
    fi
fi

if [ -n "${DRONE+x}" ]; then
    if [ -n "${DRONE_TAG+x}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${DRONE_TAG}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${GITHUB_ACTIONS+x}" ]; then
    if echo ${GITHUB_REF} | grep -q refs/tags/; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME=$(echo ${GITHUB_REF} | sed -e s@refs/.*/@@g)
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${BUILD_URL+x}" ]; then
    if echo ${BUILD_URL} | grep -q peakflow; then
        # if [ -n "${DRONE_TAG+x}" ]; then
        #     export CI_ENV_GIT_TAG=true
        #     export CI_ENV_GIT_TAG_NAME="${DRONE_TAG}"
        # else
            export CI_ENV_GIT_TAG=false
        # fi
        return
    fi
fi

if [ -n "${CI+x}" ]; then
    if [ ${CI} = "razorops" ]; then
        if [ -n "${CI_TAG+x}" ]; then
            export CI_ENV_GIT_TAG=true
            export CI_ENV_GIT_TAG_NAME="${CI_TAG}"
        else
            export CI_ENV_GIT_TAG=false
        fi
        return
    fi
fi

if [ -n "${SCRUTINIZER+x}" ]; then
    if [ -n "${CI_TAG+x}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${CI_TAG}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${SEMAPHORE+x}" ]; then
    if [ -n "${SEMAPHORE_GIT_TAG_NAME+x}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${SEMAPHORE_GIT_TAG_NAME}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${SHIPPABLE+x}" ]; then
    if [ -n "${GIT_TAG_NAME+x}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${GIT_TAG_NAME}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${TRAVIS+x}" ]; then
    if [ -n "${TRAVIS_TAG}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${TRAVIS_TAG}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${WERCKER_RUN_URL+x}" ]; then
    # if [ -n "${TRAVIS_TAG+x}" ]; then
    #     export CI_ENV_GIT_TAG=true
    #     export CI_ENV_GIT_TAG_NAME="${TRAVIS_TAG}"
    # else
        export CI_ENV_GIT_TAG=false
    # fi
    return
fi


if [ -z "${CI_ENV_GIT_TAG+x}" ]; then
    export CI_ENV_GIT_TAG=false
fi
