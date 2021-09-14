#!/bin/bash
# ALL Environment Variables

ci_env_git_commit() {
# CI_ENV_GIT_COMMIT

if [ -n "${CI_ENV_GIT_COMMIT+x}" ]; then
    return
fi

if [ -n "${AC_GIT_COMMIT+x}" ]; then
    export CI_ENV_GIT_COMMIT="${AC_GIT_COMMIT}"
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

# JFrog Pipelines
if [ -n "${JFROG_CLI_BUILD_NAME+x}" ]; then
    export CI_ENV_GIT_COMMIT=$(env | grep "res.*_commitSha" | head -1 | sed "s/.*=//")
    return
fi

# RazorOps
if [ -n "${COMMIT+x}" ]; then
    export CI_ENV_GIT_COMMIT="${COMMIT}"
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
}

ci_env_git_branch() {
# CI_ENV_GIT_BRANCH
# CI_ENV_GIT_BASE_BRANCH
# CI_ENV_GIT_SOURCE_BRANCH: provide only if pull request. (equal to CI_ENV_GIT_BRANCH)
# CI_ENV_GIT_TARGET_BRANCH: provide only if pull request. (equal to CI_ENV_GIT_BASE_BRANCH)
# CI_ENV_PULL_REQUEST

if [ -z "${CI_ENV_PULL_REQUEST+x}" ]; then
    export CI_ENV_PULL_REQUEST=false
fi

# Appcircle
if [ -n "${AC_GIT_BRANCH+x}" ]; then
    if [ "${AC_GIT_PR}" == "true" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${AC_GIT_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${AC_GIT_TARGET_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
        export CI_ENV_PULL_REQUEST=true
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${AC_GIT_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${AC_GIT_BRANCH}"
    fi
    return
fi

# AppVeyor
if [ -n "${APPVEYOR_REPO_BRANCH+x}" ]; then
    if [ -n "${APPVEYOR_PULL_REQUEST_HEAD_REPO_BRANCH}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${APPVEYOR_PULL_REQUEST_HEAD_REPO_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${APPVEYOR_REPO_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
        export CI_ENV_PULL_REQUEST=true
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
            export CI_ENV_GIT_SOURCE_BRANCH=$(echo ${SYSTEM_PULLREQUEST_SOURCEBRANCH} | sed -e s@refs/[^/]*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH=$(echo ${SYSTEM_PULLREQUEST_TARGETBRANCH} | sed -e s@refs/[^/]*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
        export CI_ENV_PULL_REQUEST=true
    else
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH=$(echo ${BUILD_SOURCEBRANCH} | sed -e s@refs/[^/]*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH=$(echo ${BUILD_SOURCEBRANCH} | sed -e s@refs/[^/]*/@@g)
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
        export CI_ENV_PULL_REQUEST=true
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
        export CI_ENV_PULL_REQUEST=true
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
    # if [ -n "${CIRCLE_PULL_REQUEST+x}" ]; then
    #     if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
    #         export CI_ENV_GIT_SOURCE_BRANCH="${CIRCLE_BRANCH}"
    #     fi
    #     if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
    #         export CI_ENV_GIT_TARGET_BRANCH="${CIRCLE_BRANCH}"
    #     fi
    # fi
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
        export CI_ENV_PULL_REQUEST=true
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
        export CI_ENV_PULL_REQUEST=true
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
    if [ "${CI_PULL_REQUEST}" == "true" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${CI_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${CI_BRANCH}"
        fi
        export CI_ENV_PULL_REQUEST=true
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
    if [ -n "${DRONE_REPO_BRANCH+x}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${DRONE_SOURCE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${DRONE_REPO_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
        export CI_ENV_PULL_REQUEST=true
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
    if [ -n "${GITHUB_BASE_REF}" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH=$(echo ${GITHUB_HEAD_REF} | sed -e s@refs/[^/]*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH=$(echo ${GITHUB_BASE_REF} | sed -e s@refs/[^/]*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
        export CI_ENV_PULL_REQUEST=true
    else
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH=$(echo ${GITHUB_REF} | sed -e s@refs/[^/]*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH=$(echo ${GITHUB_REF} | sed -e s@refs/[^/]*/@@g)
        fi
    fi
    return
fi

# JFrog Pipelines
if [ -n "${JFROG_CLI_BUILD_NAME}" ]; then
    JFROG_GITREPO_IS_PULL_REQUEST=$(env | grep "res.*_isPullRequest" | head -1 | sed "s/.*=//")
    JFROG_GITREPO_BRANCH=$(env | grep "res.*_branchName" | head -1 | sed "s/.*=//")
    if ${JFROG_GITREPO_IS_PULL_REQUEST}; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${JFROG_GITREPO_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH=$(env | grep "res.*_pullRequestBaseBranch" | head -1 | sed "s/.*=//")
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
        export CI_ENV_PULL_REQUEST=true
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH="${JFROG_GITREPO_BRANCH}"
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH="${JFROG_GITREPO_BRANCH}"
    fi
    return
fi

# Peakflow

# RazorOps
if [ -n "${CI_COMMIT_REF+x}" ]; then
    if [ "${CI_PULL_REQUEST}" != 0 ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH=$(echo ${CI_COMMIT_REF} | sed -e s@refs/[^/]*/@@g)
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH=$(echo ${CI_COMMIT_REF} | sed -e s@refs/[^/]*/@@g)
        fi
        export CI_ENV_PULL_REQUEST=true
    fi
    if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
        export CI_ENV_GIT_BRANCH=$(echo ${CI_COMMIT_REF} | sed -e s@refs/[^/]*/@@g)
    fi
    if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
        export CI_ENV_GIT_BASE_BRANCH=$(echo ${CI_COMMIT_REF} | sed -e s@refs/[^/]*/@@g)
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
        export CI_ENV_PULL_REQUEST=true
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
        export CI_ENV_PULL_REQUEST=true
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
    if [ "${IS_PULL_REQUEST}" == "true" ]; then
        if [ -z "${CI_ENV_GIT_SOURCE_BRANCH+x}" ]; then
            export CI_ENV_GIT_SOURCE_BRANCH="${HEAD_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_TARGET_BRANCH+x}" ]; then
            export CI_ENV_GIT_TARGET_BRANCH="${BASE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${CI_ENV_GIT_SOURCE_BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${CI_ENV_GIT_TARGET_BRANCH}"
        fi
        export CI_ENV_PULL_REQUEST=true
    else
        if [ -z "${CI_ENV_GIT_BRANCH+x}" ]; then
            export CI_ENV_GIT_BRANCH="${BRANCH}"
        fi
        if [ -z "${CI_ENV_GIT_BASE_BRANCH+x}" ]; then
            export CI_ENV_GIT_BASE_BRANCH="${BRANCH}"
        fi
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
        export CI_ENV_PULL_REQUEST=true
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

}

ci_env_git_tag() {
# CI_ENV_GIT_TAG
# CI_ENV_GIT_TAG_NAME

if [ -n "${CI_ENV_GIT_TAG+x}" ]; then
    if [ -n "${CI_ENV_GIT_TAG_NAME+x}" ]; then
        return
    fi
fi

if [ -n "${AC_APPCIRCLE+x}" ]; then
    if [ -n "${AC_COMMIT_TAGS}" ]; then
        export CI_ENV_GIT_TAG=true
        export CI_ENV_GIT_TAG_NAME="${AC_COMMIT_TAGS}"
    else
        export CI_ENV_GIT_TAG=false
    fi
    return
fi

if [ -n "${APPVEYOR+x}" ]; then
    if [ -n "${APPVEYOR_REPO_TAG_NAME}" ]; then
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

# JFrog Pipelines
if [ -n "${JFROG_CLI_BUILD_NAME}" ]; then
    export CI_ENV_GIT_TAG=$(env | grep "res.*_isGitTag" | head -1 | sed "s/.*=//")
    export CI_ENV_GIT_TAG_NAME=$(env | grep "res.*_gitTagName" | head -1 | sed "s/.*=//")
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
        if [ -n "${CI_TAG}" ]; then
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
    if [ -n "${GIT_TAG_NAME}" ]; then
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
}

ci_env_name() {
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

if [ -n "${JFROG_CLI_BUILD_NAME}" ]; then
    export CI_ENV_NAME="JFrog Pipelines"
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
}

ci_env_git_commit
ci_env_git_branch
ci_env_git_tag
ci_env_name
export CI=true
