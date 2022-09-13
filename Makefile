.DEFAULT_GOAL := upgrade
SHELL := bash

.PHONY: install uninstall upgrade update-dependencies postgres-password

helm_name := strmprivacy
namespace := strmprivacy

ifeq (,$(wildcard values.yaml))
  $(error You must have values.yaml with credentials. See README.md)
endif

namespace:
	kubectl create namespace ${namespace}
install:
	-helm status ${helm_name} --namespace  ${namespace} 2> /dev/null \
	|| helm install ${helm_name} helm --namespace ${namespace} \
	--values values.yaml --set namespace=${namespace}

uninstall:
	-helm status ${helm_name} --namespace  ${namespace} 2> /dev/null \
	&& helm uninstall ${helm_name} --namespace ${namespace}

upgrade:
	-helm status ${helm_name} --namespace  ${namespace} 2> /dev/null \
	&& helm upgrade ${helm_name} helm --namespace ${namespace} --debug \
	--values values.yaml --set namespace=${namespace}

template:
	helm template --debug helm --values values.yaml --set namespace=${namespace}

template-external-service:
	helm template --debug helm -s templates/web-socket/service-external.yaml --values values.yaml --set namespace=${namespace}

update-dependencies:
	helm dependency update helm

postgres-password:
	@kubectl get secret postgres -o jsonpath="{.data.postgres-password}" | base64 --decode

wipe: check_clean
	make uninstall
	kubectl delete namespace ${namespace}

check_clean:
	@echo "We're going to wipe these and uninstall helm"
	kubectl get pvc
	kubectl get secrets
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]

.PHONY: clean check_clean
