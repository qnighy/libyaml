
build:
	docker build -t yamlio/libyaml-dev .

run: build
	docker run -it --rm yamlio/libyaml-dev bash

prepare-git:
	rm -rf output/libyaml.git
	git clone ../../.git output/libyaml.git

libyaml-dist: libyaml-dist-ci

libyaml-dist-ci: prepare-git
	docker run --rm -u $$(id -u) -v$$PWD/output:/output -v$$PWD/scripts:/scripts yamlio/libyaml-dev /scripts/libyaml-dist.sh


test-pyyaml: prepare-git
	docker run --rm --env PYTHON -v$$PWD/output:/output -v$$PWD/scripts:/scripts yamlio/libyaml-dev /scripts/libyaml-test-pyyaml.sh

# Do not run on your local system. It will install libyaml.
test-pyyaml-ci: prepare-git
	OUTPUT=$$PWD/output ./scripts/libyaml-test-pyyaml.sh

clean:
	rm -rf output/libyaml.git
	rm -rf output/yaml-*.*
