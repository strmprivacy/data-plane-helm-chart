.PHONY: install uninstall
.DEFAULT_GOAL: upgrade
SHELL := bash

helm_name := strmprivacy
namespace := strmprivacy

install:
	-helm status ${helm_name} --namespace  ${namespace} 2> /dev/null \
	|| helm install --debug ${helm_name} . --namespace ${namespace} \

install-debug:
	-helm status ${helm_name} --namespace  ${namespace} 2> /dev/null \
	|| helm install --debug ${helm_name} . --namespace ${namespace}

uninstall:
	-helm status ${helm_name} --namespace  ${namespace} 2> /dev/null \
	&& helm uninstall ${helm_name} --namespace ${namespace}

uninstall-debug:
	helm uninstall --debug ${helm_name} --namespace ${namespace}

upgrade:
	-helm status ${helm_name} --namespace  ${namespace} 2> /dev/null \
	&& helm upgrade ${helm_name} . --namespace ${namespace}

upgrade-debug:
	-helm status ${helm_name} --namespace  ${namespace} 2> /dev/null \
	&& helm upgrade --debug ${helm_name} . --namespace ${namespace}

template:
	helm template --debug .

update-dependencies:
	helm dependency update
