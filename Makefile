# Build coredns docker image from a specific commit/tag

# Note:
# 1.	"VERSION" has assignments for names, tags, versions that define the build and publication 
# 2.	the "snapshot" target just builds the current state of the coredns submodule


include VERSION

.PHONY: coredns snapshot checkout build

coredns: TAG:=$(DOCKER_IMAGE_TAG)
coredns: checkout build

snapshot: TAG:=snapshot
snapshot: build

checkout:
	cd coredns && git checkout $(COREDNS_VERSION)

build:
	docker build -t $(DOCKER_IMAGE_NAME):$(TAG) .

