# Overview
This repository represents my Mac workstation and all of the software I need to do my daily job. The ubuntu-2025 branch is what I'm working on for Ubuntu too! Work in progress - cool thing I'm doing is using Docker on my Mac to get all of this situated, and then hopefully run this on my WSL2 Ubuntu instance.

### Prerequisites
I expect to run the below install script immediately after I login for the
first time on a computer. I don't even want a web browser installed as this
will do it for me. You can run this from the built in Terminal on a Mac. It
will then install iterm2 which will become my default terminal.

#### Install with curl

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mikemartin1090/environmart/ubuntu-2025/install.sh)"
```

Swap to bash for Ubuntu 22 and 24 (not sure about any lower). I just know `sh -c` stopped working and had to swap to bash...

```shell
bash -s <<< "$(curl -sLo- 'https://raw.githubusercontent.com/mikemartin1090/environmart/ubuntu-2025/install.sh')"
```

### Gotchas
At the moment, my vimrc is not installed automatically, so you will need to
copy that over manually to `~/.vimrc`. It will install the plugin manager,
but you'll likely need to launch vim after you paste this in your home
directory and run `:PlugInstall`. This will get vim in the state I like.

### Building it all out
I'm using Docker to test the Ubuntu installs, so knowing the following is helpful:

```bash
# Start a container based on an Ubuntu image
docker run -it ubuntu /bin/bash

# Install a package (e.g., vim)
apt-get update && apt-get install -y curl

# Commit the container to a new image
docker commit <container_id> ubuntu_with_curl:latest

# Run a new container based on the new image
docker run -it ubuntu_with_curl:latest /bin/bash
```
