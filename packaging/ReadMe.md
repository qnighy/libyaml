# How to make a release

## Versioning

Update libyaml version in:
* announcement.msg
* Changes
* CMakeLists.txt
  * `YAML_VERSION_MAJOR`, `YAML_VERSION_MINOR`, `YAML_VERSION_PATCH`
* .appveyor.yml
* configure.ac
  * `YAML_MAJOR`, `YAML_MINOR`, `YAML_PATCH`, `YAML_RELEASE`, `YAML_CURRENT`, `YAML_REVISION`

Commit and push everything to release/0.x.y

## Test and Create Release archives

### GitHub Actions Automation

The github workflows

    .github/workflows/pyyaml.yaml
    .github/workflows/dist.yaml

will do this automatically for you.

#### .github/workflows/pyyaml.yaml

Will test the current PyYAML master against this libyaml commit.

#### .github/workflows/dist.yaml

Will create release archives (tar.gz and zip)

### Manually

Make sure you have a clean git repository (no changed files). The following
process will clone your current git directory.

This will need the docker image `yamlio/libyaml-dev`. You can either pull
it, or create it yourself:

    make docker-build

### Run pyyaml tests on release branch

Run

    make docker-test-pyyaml

It will run all libyaml tests, and run pyyaml tests (with python 2 & 3) on
the current branch.

### Create dist archives

Run

    make docker-dist

It will run `make dist` in the container to create a tarball written to
packaging/docker/output.
It will also create a zipfile.

## Update master

    git merge release/0.x.y
    git tag -a 0.x.y
    # <Editor opens>
    # Paste the corresponding entry from the Changes file
    # Look at an earlier release for how it should look like:
    #   git show 0.2.3
    git push origin master 0.x.y

## Create a GitHub release

Go to "Releases" and click on "Draft a new release".

Fill in the tag you just created in the previous step.

Fill in the release title: v0.x.y

Paste the changelog into the description field.

Upload the tar.gz and .zip file.

You can "Save draft" and publish later, or directly click on "Publish release".

## Update pyyaml.org

* Put the resulting tarball & zip in pyyaml.org/download/libyaml
* Update wiki/LibYAML.md with release number and date
* Update wiki/index.md

Run

    make update

Check diffs and commit and push.
