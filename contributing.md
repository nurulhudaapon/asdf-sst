# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test sst https://github.com/nurulhudaapon/asdf-sst.git "sst version"

# Local Test Download
ASDF_DOWNLOAD_PATH="./dist" ASDF_INSTALL_VERSION=0.0.489 bash bin/download

# Local Test Install
ASDF_DOWNLOAD_PATH="./dist" ASDF_INSTALL_VERSION=0.0.489 ASDF_INSTALL_PATH="./dist" ASDF_INSTALL_TYPE="version" bash bin/install
```

Tests are automatically run in GitHub Actions on push and PR.
