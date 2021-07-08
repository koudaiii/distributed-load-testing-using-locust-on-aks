# Set the shell to bash always
SHELL := /bin/bash
# TODO: set your image name
NAME      := locust
VERSION   := v0.1.0
# TODO: set your repository name
DOCKER_REPOSITORY := koudaiii
DOCKER_IMAGE_NAME := $(DOCKER_REPOSITORY)/$(NAME)
DOCKER_IMAGE_TAG  ?= latest
DOCKER_IMAGE      := $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

image:
	docker build -t $(DOCKER_IMAGE) .

login:
	@docker login

push: image login
	docker push $(DOCKER_IMAGE)

run:
	docker run -d -p 8089:8089 $(DOCKER_IMAGE)
