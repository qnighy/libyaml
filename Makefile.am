## Run `./bootstrap` to generate the "Makefile.in" files in this directory and
## the "$SUBDIRS" subdirectories.

SUBDIRS = include src . tests

EXTRA_DIST = Changes ReadMe.md License CMakeLists.txt doc/doxygen.cfg

export LIBYAML_ROOT := $(PWD)

LIBYAML_TEST_SUITE_REPO ?= https://github.com/yaml/libyaml-test-suite
# LIBYAML_TEST_SUITE_COMMIT ?= 1f1b00ab6763647d05e44200b63fa62f1d2269a3

# NOTE: Uncomment to use a local copy of libyaml-test-suite
#   LIBYAML_TEST_SUITE_REPO := ../libyaml-test-suite/.git
LIBYAML_TEST_SUITE_COMMIT := devel

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = yaml-0.1.pc

maintainer-clean-local:
	rm -f aclocal.m4 config.h.in configure config/*
	-find ${builddir} -name Makefile.in -exec rm -f '{}' ';'

distclean-local:
	rm -fr test-suite packaging
	-git worktree prune

.PHONY: bootstrap test-suite
bootstrap: maintainer-clean
	./bootstrap
	./configure
	make

test-all: test test-suite

test: all
	make -C tests check-TESTS

test-suite: all
	-git clone $(LIBYAML_TEST_SUITE_REPO) $@
	( cd $@ && git reset --hard $(LIBYAML_TEST_SUITE_COMMIT) )
	make -C $@ test

docker-dist: packaging
	make -C $</docker libyaml-dist

docker-test-pyyaml: packaging
	make -C $</docker test-pyyaml

packaging:
	-git branch --track $@ origin/$@
	git worktree add --force $@ $@
