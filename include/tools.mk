define help-cmd
@echo "==> Make help"
@echo ""
@echo "make help                    -    this message"
@echo "make yaml_lint               -    lint all .yaml / .yml files in this repo"
@echo "make docker_lint             -    lint all Dockerfiles in this repo"
@echo "make flake8                  -    lint all .py files in this repo"
@echo "make pre_commit              -    yaml_lint, docker_lint, flake8 in one target"
@echo "make build_k8s_secrets       -    build docker image"
@echo "make push_k8s_secrets        -    push image to quay.io"

endef

define test-cmd
@echo "==> Testing"
@docker run --rm \
            -it \
            -v $(shell pwd)/k8s-secrets.py:/usr/local/bin/k8s-secrets.py \
            -v $(HOME)/.aws:/root/.aws \
            -v $(KUBECONFIG):/workdir/config:ro \
            -e KUBECONFIG=/workdir/config \
            quay.io/iqover8000/k8s-secrets:$(SERVICE_VERSION)
@echo ""

endef

define build-cmd
@echo "==> Building k8s-secrets image"
@docker build . -t quay.io/iqover8000/k8s-secrets:$(SERVICE_VERSION)
@echo ""

endef

define push-cmd
@echo "==> Pushing k8s-secrets to quay.io"
@docker push quay.io/iqover8000/k8s-secrets:$(SERVICE_VERSION)
@echo ""

endef

define yaml-lint-cmd
@echo "==> yaml-lint"
@docker run --rm \
            -it \
            -v $(shell pwd):/workdir \
            quay.io/omo-systems/yaml-lint:$(TOOLS_VERSION) \
            . \
            || true
@echo ""

endef

define docker-lint-cmd
@echo "==> docker-lint"
@docker run --rm \
            -it \
            -v $(shell pwd):/workdir \
            quay.io/omo-systems/docker-lint:$(TOOLS_VERSION) \
            $(shell find . -name "Dockerfile") \
            || true
@echo ""

endef

define flake8-cmd
@echo "==> flake8"
@docker run --rm \
            -it \
            -v $(shell pwd):/workdir \
            quay.io/omo-systems/flake8:$(TOOLS_VERSION) \
            . \
            || true
@echo ""

endef
