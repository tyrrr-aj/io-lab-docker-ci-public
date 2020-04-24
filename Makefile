# Git repo metadata
TAG = $(shell git describe --tags --always)
# TODO: if your docher hub account name is different then this on github ovrwrite this this variable with docer hub accout name
PREFIX = tyrrr
# TODO: if your repository name is different then this github repository name on ovrwrite this variable with docer hub repo name
REPO_NAME = lab

# Image metadata

# Name of the repository
SCHEMA_NAME = $(PREFIX)/$(REPO_NAME)
SCHEMA_DESCRIPTION = My image!
SCHEMA_URL = http://example.com

# Vendor set to github user name
SCEHMA_VENDOR = $(PREFIX)

SCHEMA_VSC_URL = https://github.com/$(PREFIX)/$(REPO_NAME)

# git commit shirt sha
SCHEMA_VCS_REF = $(shell git rev-parse --short HEAD)

SCHEMA_BUILD_DATE = $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')

SCHEMA_BUILD_VERSION = your app version - framework specyfic
SCHEMA_CMD = fire

VERSION = v_$(shell ./version.sh)
VERSION_NAME = v_$(shell cat build-version.txt)

all: push
    

image:
	docker build \
		--build-arg SCHEMA_NAME="$(SCHEMA_NAME)" \
		--build-arg SCHEMA_DESCRIPTION="$(SCHEMA_DESCRIPTION)" \
		--build-arg SCHEMA_URL="$(SCHEMA_URL)" \
		--build-arg SCEHMA_VENDOR="$(SCEHMA_VENDOR)" \
		--build-arg SCHEMA_VSC_URL="$(SCHEMA_VSC_URL)" \
		--build-arg SCHEMA_VCS_REF="$(SCHEMA_VCS_REF)" \
		--build-arg SCHEMA_BUILD_DATE="$(SCHEMA_BUILD_DATE)" \
		--build-arg SCHEMA_BUILD_VERSION="$(SCHEMA_BUILD_VERSION)" \
		--build-arg SCHEMA_CMD="$(SCHEMA_CMD)" \
		--tag $(SCHEMA_NAME):latest \
		.
	
	docker tag $(SCHEMA_NAME):latest $(SCHEMA_NAME):$(VERSION)
	
push: image
	docker push $(SCHEMA_NAME):latest
	docker push $(SCHEMA_NAME):$(VERSION_NAME)

clean:

.PHONY: clean image push
