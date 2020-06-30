# ci-normalize-envvars

Normalize environment variables for CI service

## Supported CI Services

* [AppVeyor](https://www.appveyor.com)
* [Azure Pipelines](https://azure.microsoft.com/ja-jp/services/devops/pipelines/)
* [Bitrise](https://www.bitrise.io)
* [Buddy](https://buddy.works)
* [CircleCI](https://circleci.com)
* [Cirrus CI](https://cirrus-ci.org/)
* [Codefresh](https://codefresh.io/)
* [Drone](https://cloud.drone.io/)
* [GitHub Actions](https://help.github.com/en/articles/about-github-actions)
* [Peakflow](https://www.peakflow.io/)
* [Razorops](https://razorops.com/)
* [Scrutinizer](https://scrutinizer-ci.com)
* [Semaphore](https://semaphoreci.com/product)
* [Shippable](http://shippable.com)
* [Travis CI](https://docs.travis-ci.com/)
* [wercker](http://www.wercker.com/)

## Environment Variable

|Name|Value|
|:--|:--|
|CI|true|
|(CI Service Name)|true|
|CI_ENV_NAME|CI Service Name String|
|CI_ENV_GIT_COMMIT|git commit hash|
