# coredns Docker Image

Build [coredns](https://coredns.io/) from a [source repository](https://github.com/coredns/coredns) using a [golang image](https://hub.docker.com/_/golang) and generate a simple `coredns` docker image.

## motivation

The `coredns` source has support for building a Docker image and there is a suggestion that one can compile using a `golang` image if you wish. The method used to create the `coredns` image is to compile `coredns` and then copy the binary into a minimal image.  If you are not on a Linux machine, then you need to set up go for cross-compilation (not such a big deal) if you are not using a `golang` image.

The idea here is that the compile and image build can be done in one step using the unmodified `coredns` repo.  Note that the `coredns` Makefile tries to inject the git commit id into the compiled binary, so it really wants the git repo and not a tarball.

## approach

1. The project consists of a `Makefile` to drive the process.
2. The `coredns` repo is a git submodule of the project.
3. The build relies on the `Makefile` in `coredns`, so we are building exactly the same way.
4. One can check out any commit (or run on a dirty tree) of the `coredns` submodule, and then run the build. However, the default `make` builds a particular tag or commit (set in `VERSION`) and makes sure it is checked out.  The most common use is to build a `coredns` release tag.  To build using the current state of the submodule, one uses the "snapshot" `make` target.
5. See `VERSION` to get an idea of what can be parameterized.
6. The plan is that the release tags for *this* project will coincide with `coredns` release tags such that pulling this project at a given tag will build `coredns` at the same release with no changes required.

## cloning this repo

The usual clone of this repo will not pull a copy of coredns.  You can do this in one step with:

```
% git clone --recurse-submodules https://github.com/ranger6/coredns-docker.git
```

See the [git submodule documentation](https://git-scm.com/book/en/v2/Git-Tools-Submodules) for details. 

## building the image

Once the project repository is set up, one might want to edit the `VERSION` file to suit your preferences.  Then the
build is trivial:

```
% make
```

## what else?

This project only addresses compiling from source and then building an image.  It does not address running tests, building documentation.  This should be done directly from the `coredns/coredns` project.

## running the name server

TBD

## publishing the Docker image

TBD

## testing

TBD
