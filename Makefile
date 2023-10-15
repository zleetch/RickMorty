BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
RESET=$(shell tput sgr0)

ROOTPATH=$(shell pwd)

.ONESHELL:
.SHELL := /usr/bin/bash
.PHONY: apply delete output

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

set-env:
	@if [ -z $(env) ]; then \
		echo "$(BOLD)$(RED)ENV was not set$(RESET)"; \
		ERROR=1; \
	 fi
	@if [ -z $(stack) ]; then \
		echo "$(BOLD)$(RED)ENV was not set$(RESET)"; \
		ERROR=1; \
	 fi

apply: set-env ## Create or configured the manifest
	@kubectl kustomize $(ROOTPATH)/$(stack)/overlays/$(env) --enable-helm | kubectl apply -f -

delete: set-env ## Delete or destroy the manifest
	@kubectl kustomize $(ROOTPATH)/$(stack)/overlays/$(env) --enable-helm | kubectl delete -f -

output: set-env ## Get output of the manifest
	@kustomize build $(ROOTPATH)/$(stack)/overlays/$(env) --enable-helm > $(ROOTPATH)/$(stack)/overlays/$(env)/output.yaml