#!/bin/bash

OUTPUT="${OUTPUT:-/output}"
set -ex

if [[ -z $CI ]]; then
    echo "Only run in CI" >&2
    exit 1
fi

$PYTHON --version

cp -r $OUTPUT/libyaml.git /tmp/
cd /tmp/libyaml.git

./bootstrap
./configure
make test
sudo make install
sudo ldconfig

git clone https://github.com/yaml/pyyaml.git /tmp/pyyaml
cd /tmp/pyyaml
$PYTHON setup.py test

echo "$PYTHON pyyaml successful"
