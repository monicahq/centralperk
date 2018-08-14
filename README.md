# CentralPerk
A place to test Monica

[![](https://images.microbadger.com/badges/image/monicahq/circleci-docker-centralperk.svg)](https://microbadger.com/images/monicahq/circleci-docker-centralperk "Get your own image badge on microbadger.com")

## Introduction
This repository creates a docker image designed to run tests for [Monica](https://github.com/monicahq/monica).
It is used on CircleCI, but it should works on every Docker host.

## Content
The [CentraPerk](https://hub.docker.com/r/monicahq/circleci-docker-centralperk/) image contains:
* circleci/php:7.2-node-browsers image
* mysql client
* latest Chrome browser
* Needed php extensions

## License

Copyright (c) 2018

Licensed under the AGPL License. [View license](/LICENSE).