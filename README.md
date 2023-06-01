# Overview
This repository represents my Mac workstation and all of the software I need to do my daily job.

### Prerequisites
I expect to run the below install script immediately after I login for the
first time on a computer. I don't even want a web browser installed as this
will do it for me. You can run this from the built in Terminal on a Mac. It
will then install iterm2 which will become my default terminal.

#### Install with curl

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mikemartin1090/environmart/master/install.sh)"
```

### Gotchas
At the moment, my vimrc is not installed automatically, so you will need to
copy that over manually to `~/.vimrc`. It will install the plugin manager,
but you'll likely need to launch vim after you paste this in your home
directory and run `:PlugInstall`. This will get vim in the state I like.
