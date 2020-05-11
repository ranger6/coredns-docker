# build coredns docker image from a specific commit/tag

# Note:
# 1.	"VERSION" has assignments for names, tags, versions that define the build and publication 
# 2.	the "snapshot" target just builds the current state of the coredns submodule


include VERSION

.PHONY: coredns snapshot checkout compile build

coredns: TAG:=$(DOCKER_IMAGE_TAG)
coredns: checkout compile build

snapshot: TAG:=snapshot
snapshot: compile build

checkout:
	cd coredns && git checkout $(COREDNS_VERSION)

compile:
	docker run --rm -i -t -v $(PWD):/app -w /app/coredns golang:1.14 make 

build:
	cd coredns && docker build -t $(DOCKER_IMAGE_NAME):$(TAG) .

