.DEFAULT_GOAL := upgrade
SHELL := bash

.PHONY: install uninstall upgrade update-dependencies postgres-password

install:
	make -C helm install

uninstall:
	make -C helm uninstall

upgrade:
	make -C helm upgrade

template:
	make -C helm template

update-dependencies:
	make -C helm update-dependencies

postgres-password:
	@kubectl get secret postgres -o jsonpath="{.data.postgres-password}" | base64 --decode

wipe: check_clean
	make uninstall
	kubectl delete pvc --all
	kubectl delete secrets --all

check_clean:
	@echo "We're going to wipe these and uinstall helm"
	kubectl get pvc
	kubectl get secrets
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]

.PHONY: clean check_clean
