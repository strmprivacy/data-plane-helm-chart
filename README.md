# STRM Privacy Data Plane Helm Chart

## What is STRM Privacy?

[STRM Privacy](https://strmprivacy.io) is a privacy (and security) focused data processing platform. Define your data shape and the privacy implications in a `data contract`, and we take care of all the necessary transformations and split your data into `privacy streams`, a dedicated purpose-bound data interface that contains, for instance, only anonymized data. 

With the Data Plane Helm Chart you can install all data processing components on your own Kubernetes cluster. This way,
data never leaves **your** infrastructure, regardless of where your Kubernetes cluster is running.

## prerequisites

This Helm Chart assumes that you have the following infrastructure up and running:

- Kafka (or something which is Kafka API compatible)
- Redis (or something which is Redis API compatible)
- A Postgres Database

Note that the Helm Chart does include these, but they are not optimized for production. If you'd like to use the
included versions of these prerequisites, please contact STRM Privacy, so we can support you and improve the Helm Chart.

## Installation instructions

1. [Create an account](https://console.strmprivacy.io) or log in to the STRM console
2. Request a trial and demo for self-hosted installations through go [@] strmprivacy.io
3. Once upgraded to support self-hosted installations, please navigate to
the [console](https://console.strmprivacy.io) and follow the instructions for setting up your self-hosted installation
on the home page. You can find the required credentials and copy them in the `values.yaml` file, or download the fully
generated `values.yaml` to get you started even faster. Installation can be done as follows:
  1. Create a namespace that matches the name in the `values.yaml`, the default is `strmprivacy` (all resources will be
   created in this namespace)
  2. Run `helm install strmprivacy helm --namespace strmprivacy` from the root of this repository (this chart will be
   published to a Helm repository for even easier installation)

Do not hesitate to [contact us](https://docs.strmprivacy.io/docs/latest/contact/) if you need assistance!

## Contributing

The chart is considered to be an alpha version. If you encounter issues
while using the chart, please check whether the issue you encounter has already been listed in the issue list. If not,
feel free to create an issue.

Pull requests are greatly appreciated.
