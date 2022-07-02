# ci-normalize-envvars

Normalize environment variables for CI service

## Supported CI Services

* [Appcircle][]
* [AppVeyor][]
* [Azure Pipelines][]
* [Bitrise][]
* [Buddy][]
* [CircleCI][]
* [Cirrus CI][]
* [Codefresh][]
* [Drone][]
* [GitHub Actions][]
* [JFrog Pipelines][]
* [Peakflow][]
* [Razorops][]
* [Scrutinizer][]
* [Semaphore][]
* [Travis CI][]

## Environment Variable

|Name|Value|
|:--|:--|
|CI|true|
|(CI Service Name)|true|
|CI_ENV_NAME|CI Service Name String|
|CI_ENV_GIT_COMMIT|git commit hash|
|CI_ENV_GIT_BRANCH|git current branch|
|CI_ENV_GIT_BASE_BRANCH|git base branch|
|CI_ENV_GIT_SOURCE_BRANCH|provide only if pull request. (equal to CI_ENV_GIT_BRANCH|
|CI_ENV_GIT_TARGET_BRANCH|provide only if pull request. (equal to CI_ENV_GIT_BASE_BRANCH)|
|CI_ENV_GIT_TAG|git tag (true/false)|
|CI_ENV_GIT_TAG_NAME|git tag name, provide only if CI_ENV_GIT_TAG == true|
|CI_ENV_PULL_REQUEST|is pull requrest|

[Appcircle]:https://appcircle.io/
[AppVeyor]:https://www.appveyor.com
[Azure Pipelines]:https://azure.microsoft.com/ja-jp/services/devops/pipelines/
[Bitrise]:https://www.bitrise.io
[Buddy]:https://buddy.works
[CircleCI]:https://circleci.com
[Cirrus CI]:https://cirrus-ci.org/
[Codefresh]:https://codefresh.io/
[Codeship]:https://codeship.com/
[Drone]:https://cloud.drone.io/
[GitHub Actions]:https://help.github.com/en/articles/about-github-actions
[JFrog Pipelines]:https://www.jfrog.com/confluence/display/JFROG/JFrog+Pipelines
[Peakflow]:https://www.peakflow.io/
[Razorops]:https://razorops.com/
[Scrutinizer]:https://scrutinizer-ci.com
[Semaphore]:https://semaphoreci.com/product
[Travis CI]:https://travis-ci.com/
