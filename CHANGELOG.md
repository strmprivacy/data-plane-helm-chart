## [1.7.2](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.7.1...v1.7.2) (2022-06-17)


### Bug Fixes

* **strm-1247:** change to correct oci path ([a3a9120](https://github.com/strmprivacy/data-plane-helm-chart/commit/a3a9120272ed5725858c7f9e854ce41a76a23706))

## [1.7.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.7.0...v1.7.1) (2022-06-17)


### Bug Fixes

* **strm-1247:** helm chart command does not exist ([45a22be](https://github.com/strmprivacy/data-plane-helm-chart/commit/45a22be99a1bf1deb9776ad767808f72f74e30ec))

# [1.7.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.6.0...v1.7.0) (2022-06-16)


### Features

* **strm-1247:** push helm chart to AWS ECR for marketplace installations ([e038300](https://github.com/strmprivacy/data-plane-helm-chart/commit/e038300f0ff08349c1e1af6646f708621f67711b))

# [1.6.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.5.0...v1.6.0) (2022-06-16)


### Features

* **strm-1272:** add installation type; enable/disable parts based on installation type ([f489626](https://github.com/strmprivacy/data-plane-helm-chart/commit/f489626200ca2b72176fc8da7fbd8aa9882406e2))
* **strm-1272:** add values schema; add environment variable for installation type ([4c90e65](https://github.com/strmprivacy/data-plane-helm-chart/commit/4c90e651e53752d2fa906ea212f6beeb7d7af175))
* **strm-1272:** toggle image and imagepullsecrets based on installation type ([4ac670c](https://github.com/strmprivacy/data-plane-helm-chart/commit/4ac670cefec76cb5d228860cb49cbae039f39913))
* **strm-1272:** update default installation type to SELF_HOSTED ([51a359c](https://github.com/strmprivacy/data-plane-helm-chart/commit/51a359c9123fdd33b0aa182cead19dda595af515))

# [1.5.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.4.1...v1.5.0) (2022-05-31)


### Bug Fixes

* missing dependent charts ([#15](https://github.com/strmprivacy/data-plane-helm-chart/issues/15)) ([fe66af2](https://github.com/strmprivacy/data-plane-helm-chart/commit/fe66af2d9143ce189d05d3050ef80bbe29c4ede8))


### Features

* service-monitor event-gateway ([#14](https://github.com/strmprivacy/data-plane-helm-chart/issues/14)) ([3400c30](https://github.com/strmprivacy/data-plane-helm-chart/commit/3400c30f63798a2a888da2cc2ca41c980d1d2ea6))

## [1.4.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.4.0...v1.4.1) (2022-05-19)


### Bug Fixes

* add semantic release for github ([3acf603](https://github.com/strmprivacy/data-plane-helm-chart/commit/3acf6033154f48a045ee8b5eb7edd26fb44b5938))

# [1.4.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.3.0...v1.4.0) (2022-05-16)


### Bug Fixes

* update ci node version ([1bf85b6](https://github.com/strmprivacy/data-plane-helm-chart/commit/1bf85b6fa2a671ca28176716f331dcd1e482c578))


### Features

* update github ci ([e31ed95](https://github.com/strmprivacy/data-plane-helm-chart/commit/e31ed953bdfc568faf5ff0ed75fc9205bc1f610f))

# [1.3.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.2.0...v1.3.0) (2022-05-13)


### Features

* create postgres secret with custom password ([#10](https://github.com/strmprivacy/data-plane-helm-chart/issues/10)) ([aacce1d](https://github.com/strmprivacy/data-plane-helm-chart/commit/aacce1d727bcf917d27159f3845a4a1d9d13792a))

# [1.2.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.1.0...v1.2.0) (2022-05-11)


### Features

* esr proxy added ([b492c4d](https://github.com/strmprivacy/data-plane-helm-chart/commit/b492c4de74e491aa80fd36b56dcb0e7e27996094))
* esr-proxy ([3f5b1a0](https://github.com/strmprivacy/data-plane-helm-chart/commit/3f5b1a0ff98cf5e0f369d2025e07e99ed4ee7e44))

# [1.1.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.0.0...v1.1.0) (2022-05-10)


### Features

* docs and version upgrades ([0c2e370](https://github.com/strmprivacy/data-plane-helm-chart/commit/0c2e370b617b33361976da14bd8e81850dc02c48))

# 1.0.0 (2022-05-05)


### Bug Fixes

* envoy audience for event-gateway and web-socket ([fd91a49](https://github.com/strmprivacy/data-plane-helm-chart/commit/fd91a4919228ffe2e529c29e997fcd2ccd1b5506))


### Features

* add confluent schema proxy ([43fbd0a](https://github.com/strmprivacy/data-plane-helm-chart/commit/43fbd0a7831a2b5726e41e838260e9d6708a0f7a))
* confluent schema proxy ([3a4b83f](https://github.com/strmprivacy/data-plane-helm-chart/commit/3a4b83f5d63f735b4dea4e0d858cdcc2bbbc5bf7))
* initial commit ([578f7ab](https://github.com/strmprivacy/data-plane-helm-chart/commit/578f7ab5b85de53d8b0ba73fcff5f1c735b9878a))
* publish helm tarball to public google cloud bucket ([#4](https://github.com/strmprivacy/data-plane-helm-chart/issues/4)) ([4a62f2c](https://github.com/strmprivacy/data-plane-helm-chart/commit/4a62f2c765ea921723874eb08354cd8c8b6d77a9))
