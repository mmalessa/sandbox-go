CGO_ENABLED = 0 # statically linked = 0
TARGETOS=linux
ifeq ($(OS),Windows_NT) 
    TARGETOS := Windows
else
    TARGETOS := $(shell sh -c 'uname 2>/dev/null || echo Unknown' | tr '[:upper:]' '[:lower:]')
endif
TARGETARCH = amd64

.DEFAULT_GOAL = help
PID = /tmp/serving.pid
DEVELOPER_UID     ?= $(shell id -u)
DC = docker compose
#-----------------------------------------------------------------------------------------------------------------------

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: build
build: ## Build dev image
	@$(DC) build 											\
	
.PHONY: up
up: ## Start application dev container
	@$(DC) up -d

.PHONY: down
down: ## Remove application dev container
	@$(DC) down

.PHONY: shell
shell: ## Enter application dev container
	@$(DC) exec -it application bash

.PHONY: go-build
go-build: ## Build dev application (go build)
	@$(DC) exec application sh -c "go mod tidy"
#    @$(DC) exec sh -c "env CGO_ENABLED=${CGO_ENABLED} GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -ldflags '-X main.env=dev' -o bin/app ./"
	@$(DC) exec application sh -c "env CGO_ENABLED=${CGO_ENABLED} GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o bin/app ./"

.PHONY: clean
clean: ## Clean bin/
	@$(DC) exec application sh - c "rm -rf bin/app"
