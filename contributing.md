# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test sst https://github.com/nurulhudaapon/asdf-sst.git "sst version"

# Test canary
asdf plugin test sst https://github.com/nurulhudaapon/asdf-sst.git --asdf-tool-version 3.2.64 --asdf-plugin-gitref canary "sst version"

# Install canary
asdf plugin update sst canary

# Local Test Download
ASDF_DOWNLOAD_PATH="./dist" ASDF_INSTALL_VERSION=3.2.64 bash bin/download

# Local Test Install
ASDF_DOWNLOAD_PATH="./dist" ASDF_INSTALL_VERSION=3.2.64 ASDF_INSTALL_PATH="./dist" ASDF_INSTALL_TYPE="version" bash bin/install
```

Tests are automatically run in GitHub Actions on push and PR.
