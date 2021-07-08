# Set the shell to bash always
SHELL := /bin/bash
# TODO: set your image name
NAME      := myapp
VERSION   := v0.1.0
REVISION  := $(shell git rev-parse --short HEAD)

SRCS      := $(shell find . -name '*.go' -type f)
LDFLAGS   := -ldflags="-s -w -X \"main.Version=$(VERSION)\" -X \"main.GitCommit=$(REVISION)\""

DIST_DIRS := find * -type d -exec
# TODO: set your repository name
DOCKER_REPOSITORY := koudaiii
DOCKER_IMAGE_NAME := $(DOCKER_REPOSITORY)/$(NAME)
DOCKER_IMAGE_TAG  ?= latest
DOCKER_IMAGE      := $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

image: clean mod tidy lint test build
ifeq ($(findstring ELF 64-bit LSB,$(shell file bin/$(NAME) 2> /dev/null)),)
	@echo "bin/$(NAME) is not a binary of Linux 64bit binary."
	@exit 1
endif
	docker build -t $(DOCKER_IMAGE) .

build:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build $(LDFLAGS) -o bin/$(NAME)

mod:
	go mod vendor

login:
	@docker login

push: image login
	docker push $(DOCKER_IMAGE)

run:
	docker run -d -p 1323:1323 $(DOCKER_IMAGE)

clean:
	rm -rf bin/*
	rm -rf vendor/*

test:
	go test -v ./...

tidy:
	go mod tidy

lint:
	$(LINT) run

LINT=$(shell which golangci-lint)
