# [2.0.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.26.0...v2.0.0) (2023-08-02)


### Features

* **strm-2570:** simplify kafka security configuration and support saslJaasConfig ([#35](https://github.com/strmprivacy/data-plane-helm-chart/issues/35)) ([8476941](https://github.com/strmprivacy/data-plane-helm-chart/commit/8476941f1459ccfb1d6441b577ec5a71bc0884c8))


### BREAKING CHANGES

* **strm-2570:** The component-level kafkaAuth configurations have been removed in favour of a global kafka security config.

# [1.26.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.25.1...v1.26.0) (2023-07-27)


### Features

* **strm-2568:** add kafka property to enable Avro JSON serialization ([#34](https://github.com/strmprivacy/data-plane-helm-chart/issues/34)) ([a958091](https://github.com/strmprivacy/data-plane-helm-chart/commit/a958091a81f3de420a39108cab803894bd982137))

## [1.25.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.25.0...v1.25.1) (2023-06-22)


### Bug Fixes

* **release:** running batch jobs were redeployed when the image version changed ([f20cacf](https://github.com/strmprivacy/data-plane-helm-chart/commit/f20cacfeabbc03ce3f2b3737dce75bf30ac7712a))

# [1.25.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.24.0...v1.25.0) (2023-06-20)


### Features

* **release:** fixed batch-job-runner for micro-aggregations ([18283b6](https://github.com/strmprivacy/data-plane-helm-chart/commit/18283b64d13a52b7f0ed96b113b95b12723684fe))

# [1.24.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.23.2...v1.24.0) (2023-06-09)


### Features

* various agent dependency upgrades ([663e86d](https://github.com/strmprivacy/data-plane-helm-chart/commit/663e86d214377c5bf137f2e83fcfcba6c8be4986))

## [1.23.2](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.23.1...v1.23.2) (2023-06-06)


### Bug Fixes

* **strm-2450:** add watch verb to all roles ([#31](https://github.com/strmprivacy/data-plane-helm-chart/issues/31)) ([8735bd6](https://github.com/strmprivacy/data-plane-helm-chart/commit/8735bd62a07c8d84aace1cb610669319c1f7cab1))

## [1.23.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.23.0...v1.23.1) (2023-05-30)


### Bug Fixes

* helm gcs plugin on master is broken, use fixed version ([5cb0e64](https://github.com/strmprivacy/data-plane-helm-chart/commit/5cb0e649d31bc6886e6ef0a962b0eaae9aeb7be7))

# [1.23.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.22.1...v1.23.0) (2023-05-30)


### Features

* update various dependencies of data plane applications ([74732fb](https://github.com/strmprivacy/data-plane-helm-chart/commit/74732fb5c06cbd2f95e724ec51f5998da6192736))

## [1.22.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.22.0...v1.22.1) (2023-04-24)


### Bug Fixes

* update version for batch-jobs-agent ([962d70e](https://github.com/strmprivacy/data-plane-helm-chart/commit/962d70ec0a36d2c0fa0988891871bbc0c5b7714c))

# [1.22.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.21.2...v1.22.0) (2023-04-11)


### Features

* **strm-2343:** allow configuration of resources; add default metrics and dashboards ([6747d28](https://github.com/strmprivacy/data-plane-helm-chart/commit/6747d28cd8185defa46a555967152d75cc3f85d8))

## [1.21.2](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.21.1...v1.21.2) (2023-03-31)


### Bug Fixes

* ensure servicemonitors are only installed when prometheus and the component are enabled ([960b725](https://github.com/strmprivacy/data-plane-helm-chart/commit/960b725ba81b03c00a154448b9b29b1237b16c26))

## [1.21.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.21.0...v1.21.1) (2023-02-03)


### Bug Fixes

* **strm-2276:** add missing agent rbac & improve default postgres pw setup ([#29](https://github.com/strmprivacy/data-plane-helm-chart/issues/29)) ([dbca796](https://github.com/strmprivacy/data-plane-helm-chart/commit/dbca796f50a0f06bad7f9bacad196167c20bdcd9))

# [1.21.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.20.2...v1.21.0) (2023-01-31)


### Features

* **strm-2020:** support for private registries ([2e52b04](https://github.com/strmprivacy/data-plane-helm-chart/commit/2e52b04f005d1c210682e722767455de147d0458))

## [1.20.2](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.20.1...v1.20.2) (2022-11-14)


### Bug Fixes

* **strm-1995:** use release namespace ([#26](https://github.com/strmprivacy/data-plane-helm-chart/issues/26)) ([09eef21](https://github.com/strmprivacy/data-plane-helm-chart/commit/09eef212893e245f17d93c7bdf2ed2fb6d665518))

## [1.20.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.20.0...v1.20.1) (2022-10-26)


### Bug Fixes

* add optional service account name ([4ef857b](https://github.com/strmprivacy/data-plane-helm-chart/commit/4ef857b1d8d0ed713a38a8fb602b483c39fcd696))

# [1.20.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.19.1...v1.20.0) (2022-10-24)


### Features

* aws marketplace payg support ([dad7a7c](https://github.com/strmprivacy/data-plane-helm-chart/commit/dad7a7c5cd72ab76e6da71c9674c4c2ff884ca8b))

## [1.19.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.19.0...v1.19.1) (2022-10-24)


### Bug Fixes

* length of marketplace override parameter label > 50 ([bad4383](https://github.com/strmprivacy/data-plane-helm-chart/commit/bad43834118e48c0265a1a3304f8e8648209bcfb))

# [1.19.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.18.1...v1.19.0) (2022-10-24)


### Features

* aws Marketplace payg support ([452526f](https://github.com/strmprivacy/data-plane-helm-chart/commit/452526f2d8a11382e15f84ac90b5814350ea533a))

## [1.18.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.18.0...v1.18.1) (2022-10-24)


### Bug Fixes

* jq flatten ([9f25d3a](https://github.com/strmprivacy/data-plane-helm-chart/commit/9f25d3aac3ab937c240e545e2d4d978921d401a5))

# [1.18.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.17.3...v1.18.0) (2022-10-24)


### Features

* **strm-1782:** add default service account ([#25](https://github.com/strmprivacy/data-plane-helm-chart/issues/25)) ([dc3d89f](https://github.com/strmprivacy/data-plane-helm-chart/commit/dc3d89fc06c48a099ca88cfdfaf21ccb5d1ccd60))

## [1.17.3](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.17.2...v1.17.3) (2022-10-18)


### Bug Fixes

* **strm-1779:** retry marketplace sa account test ([08fa7f3](https://github.com/strmprivacy/data-plane-helm-chart/commit/08fa7f3cd281f1b0b556df0832764e1afdf8fbbd))

## [1.17.2](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.17.1...v1.17.2) (2022-10-18)


### Bug Fixes

* **strm-1779:** add the aws mp sa to the values.yaml ([ec67582](https://github.com/strmprivacy/data-plane-helm-chart/commit/ec67582f2a4afd5d0ec56d3f40a70f88aa23e3b5))

## [1.17.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.17.0...v1.17.1) (2022-10-18)


### Bug Fixes

* **strm-1779:** retry with different default value ([05a8386](https://github.com/strmprivacy/data-plane-helm-chart/commit/05a8386f8d11e50118b817dbbd6c5aff08eba651))

# [1.17.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.16.0...v1.17.0) (2022-10-18)


### Features

* **strm-1779:** add override parameter for PAYG product listing ([e04bcb1](https://github.com/strmprivacy/data-plane-helm-chart/commit/e04bcb15e226bf0b1ba0306e2a78829aabb966f6))

# [1.16.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.15.0...v1.16.0) (2022-10-14)


### Features

* **strm-1779:** support for aws marketplace payg version ([#24](https://github.com/strmprivacy/data-plane-helm-chart/issues/24)) ([0cd859b](https://github.com/strmprivacy/data-plane-helm-chart/commit/0cd859ba80f36e68fa7f0c718ef90853d2493b57))

# [1.15.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.14.1...v1.15.0) (2022-09-14)


### Features

* **strm-1615:** allow allowed client ip cidr and lb ip config ([#23](https://github.com/strmprivacy/data-plane-helm-chart/issues/23)) ([79b014b](https://github.com/strmprivacy/data-plane-helm-chart/commit/79b014b2d898493c74b97e6fa156de1c696beea4))

## [1.14.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.14.0...v1.14.1) (2022-09-13)


### Bug Fixes

* **master:** publish to aws; missing comma ([8641178](https://github.com/strmprivacy/data-plane-helm-chart/commit/8641178b7557a7a6d6a08040ff7b9c2a4ad483ba))

# [1.14.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.13.0...v1.14.0) (2022-09-13)


### Features

* **strm-1593:** allow arbitrary annotations on the load balancer ([#22](https://github.com/strmprivacy/data-plane-helm-chart/issues/22)) ([d8c9988](https://github.com/strmprivacy/data-plane-helm-chart/commit/d8c99883203bc8b6bdd30e44b3d6ff22b46ec368))

# [1.13.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.12.0...v1.13.0) (2022-09-05)


### Features

* **strm-1586:** allow routing traffic via load balancer ([b8ead9d](https://github.com/strmprivacy/data-plane-helm-chart/commit/b8ead9d2896f88480b433e571524301a1d5097a7))

# [1.12.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.11.0...v1.12.0) (2022-07-15)


### Features

* **strm-1332:** update jwks endpoints for event gateway and web socket ([#20](https://github.com/strmprivacy/data-plane-helm-chart/issues/20)) ([3f4affc](https://github.com/strmprivacy/data-plane-helm-chart/commit/3f4affc5dd2d3c8a2a03c0e74619fb5fb9d7b3c6))

# [1.11.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.10.1...v1.11.0) (2022-07-01)


### Features

* **strm-1130:** authenticated Kafka access ([2e73f7d](https://github.com/strmprivacy/data-plane-helm-chart/commit/2e73f7d1e0f72b77b3aea9f31a1dac266c78a5df))

## [1.10.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.10.0...v1.10.1) (2022-06-29)


### Bug Fixes

* disable quicklaunch as it does not work after several attempts ([7ea0305](https://github.com/strmprivacy/data-plane-helm-chart/commit/7ea0305c18123f13c060603c5f7c4223e447fe92))

# [1.10.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.9.0...v1.10.0) (2022-06-28)


### Features

* enable embedded infra by default ([#18](https://github.com/strmprivacy/data-plane-helm-chart/issues/18)) ([7f687f4](https://github.com/strmprivacy/data-plane-helm-chart/commit/7f687f4f4235717b1a5d1f702e94f217340dccc9))

# [1.9.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.8.4...v1.9.0) (2022-06-27)


### Features

* **strm-1278:** add override parameters to version ([24dc610](https://github.com/strmprivacy/data-plane-helm-chart/commit/24dc6108f502226a060a42b56e8f511c9267f930))

## [1.8.4](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.8.3...v1.8.4) (2022-06-27)


### Bug Fixes

* **strm-1278:** assign id to get release step ([1770110](https://github.com/strmprivacy/data-plane-helm-chart/commit/177011035b68480c0d8e834b3a55efcd4803cb73))

## [1.8.3](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.8.2...v1.8.3) (2022-06-27)


### Bug Fixes

* **strm-1278:** output should be unquoted ([8fa8e74](https://github.com/strmprivacy/data-plane-helm-chart/commit/8fa8e74fea08d97fa0a735fa8eefac6f12b64b2b))

## [1.8.2](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.8.1...v1.8.2) (2022-06-27)


### Bug Fixes

* **strm-1278:** secret should be an env var ([53aa973](https://github.com/strmprivacy/data-plane-helm-chart/commit/53aa9739ae4804e68c35e758f5bb348373d16df8))

## [1.8.1](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.8.0...v1.8.1) (2022-06-27)


### Bug Fixes

* **strm-1278:** missing $ breaks script ([b37d432](https://github.com/strmprivacy/data-plane-helm-chart/commit/b37d432fbada453c800f579a9298b9714986bfcd))

# [1.8.0](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.7.5...v1.8.0) (2022-06-27)


### Features

* **strm-1278:** create new aws version for each release ([d3351c8](https://github.com/strmprivacy/data-plane-helm-chart/commit/d3351c8b265d6b65b686c57486e96fc7d8024ad5))

## [1.7.5](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.7.4...v1.7.5) (2022-06-17)


### Bug Fixes

* **strm-1247:** changed permissions for AWS ECR publisher creds ([eb9ff84](https://github.com/strmprivacy/data-plane-helm-chart/commit/eb9ff84c224ebfba83e73f7dabc3d9c1c30e0358))

## [1.7.4](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.7.3...v1.7.4) (2022-06-17)


### Bug Fixes

* **strm-1247:** try it with the aws cli ([2c56aec](https://github.com/strmprivacy/data-plane-helm-chart/commit/2c56aec46dec1710d27c08c0bc4eeabb54f7cf1e))

## [1.7.3](https://github.com/strmprivacy/data-plane-helm-chart/compare/v1.7.2...v1.7.3) (2022-06-17)


### Bug Fixes

* **strm-1247:** aWS ECR is picky when publishing Helm charts ([a7007cf](https://github.com/strmprivacy/data-plane-helm-chart/commit/a7007cf5d66b30d5c4c0d201978050ca55a1d73e))

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
