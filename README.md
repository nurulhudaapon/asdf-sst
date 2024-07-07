<div align="center">

# asdf-sst [![Build](https://github.com/nurulhudaapon/asdf-sst/actions/workflows/build.yml/badge.svg)](https://github.com/nurulhudaapon/asdf-sst/actions/workflows/build.yml) [![Lint](https://github.com/nurulhudaapon/asdf-sst/actions/workflows/lint.yml/badge.svg)](https://github.com/nurulhudaapon/asdf-sst/actions/workflows/lint.yml)

[sst](https://ion.sst.dev) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add sst
# or
asdf plugin add sst https://github.com/nurulhudaapon/asdf-sst.git
```

sst:

```shell
# Show all installable versions
asdf list-all sst

# Install specific version
asdf install sst latest

# Set a version globally (on your ~/.tool-versions file)
asdf global sst latest

# Now sst commands are available
sst version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/nurulhudaapon/asdf-sst/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Nurul Huda (Apon)](https://github.com/nurulhudaapon/)
