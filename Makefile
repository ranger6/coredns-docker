# build coredns docker image from a specific commit/tag

# Note:
# 1.	"VERSION" has assignments for names, tags, versions that define the build and publication.
# 2.	The "snapshot" target just builds the current state of the coredns submodule.
# 3.	One can build the Docker image directly ("build"), expecting a pre-existing coredns binary.
#           In this case, the TAG is set to "snapshot" since we can't be sure how the binary was built.
#           If you want a specific TAG, set it on the command line: e.g. "make TAG=latest"

TIMESTAMP := $(shell date -u +%Y%m%d%H%M%S)
TAG := snapshot
include VERSION

.PHONY: coredns snapshot update checkout compile build

coredns: TAG := $(DOCKER_IMAGE_TAG)
coredns: checkout compile build

snapshot: compile build

update:
	git pull --recurse-submodules

checkout:
	cd coredns && git checkout $(COREDNS_VERSION)

compile:
	docker run --rm -i -t -v $(PWD):/app -w /app/coredns golang:1.14 make 

build:
	cd coredns && docker build -t $(DOCKER_IMAGE_NAME):$(TIMESTAMP) .
	docker tag $(DOCKER_IMAGE_NAME):$(TIMESTAMP) $(DOCKER_IMAGE_NAME):$(TAG)

