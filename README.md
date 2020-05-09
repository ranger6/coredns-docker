# coredns Docker Image

Build [coredns](https://coredns.io/) from a [source repository](https://github.com/coredns/coredns) using a [golang image](https://hub.docker.com/_/golang) and generate a simple `coredns` docker image.

## motivation

The `coredns` source (AFAICS) has some support for building a Docker image and there is a suggestion that one can compile using a `golang` image if you wish. The method used to create the `coredns` image is to compile `coredns` and then copy the binary into a minimal image.  If you are not on a Linux machine, then you need to set up go for cross-compilation (not such a big deal) if you are not using a `golang` image.

The idea here is that the compile and image build can be done in one step using the unmodified `coredns` repo.  Note that the `coredns` Makefile tries to inject the git commit id into the compiled binary, so it really wants the git repo and not a tarball.

The goal is that building a `coredns` docker image at a given release tag will consist of:

```
% git checkout <tag>
% make
```

## approach

1. The project consists of a Makefile/Dockerfile to drive the process.
2. The `coredns` repo is a git submodule of the project.
3. The build relies (mostly) on the Makefile in `coredns`, so we are building exactly the same way.
4. One can check out any commit (or run on a dirty tree) of the `coredns` submodule, and then run the build. However, the default `make` builds a particular tag or commit (set in `VERSION`) and makes sure it is checked out.  The most common use is to build a `coredns` release tag.  To build using the current state of the submodule, one uses the "snapshot" `make` target.
5. See `VERSION` to get an idea of what can be parameterized.
6. The plan is that the release tags for *this* project will coincide with `coredns` release tags such that pulling this project at a given tag will build `coredns` at the same release with no changes required.

The *mostly* caveat above refers to the fact that the `coredns` Dockerfile code has been copied here and so is a bit fragile.

