TOOLS_VERSION=0.1.0
SERVICE_VERSION=0.1.0

include include/*.mk

.DEFAULT_GOAL := help

help::
	$(call help-cmd)

yaml_lint::
	$(call yaml-lint-cmd)

docker_lint::
	$(call docker-lint-cmd)

flake8::
	$(call flake8-cmd)

pre_commit::
	$(call yaml-lint-cmd)
	$(call docker-lint-cmd)
	$(call flake8-cmd)

build_k8s_secrets::
	$(call build-cmd)

push_k8s_secrets::
	$(call push-cmd)

test_k8s_secrets::
	$(call test-cmd)
