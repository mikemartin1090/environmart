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

### Maintenance
Interactive shell startup only loads configuration and does not install or
upgrade software. Run these commands intentionally when setting up a machine
or maintaining it:

```shell
environmart_install_tools
environmart_update
```

`environmart_update` runs `brew update`, upgrades formulae and casks, cleans
Homebrew, and updates the managed global NPM package. If you have an existing
installation, run `rl` once after updating Environmart so its cached files in
`~/run` are refreshed. Node tooling is loaded lazily, so using `node`, `npm`,
or `nvm` pays the NVM load cost only in that shell. A local reminder appears
every 14 days and resets after a successful update. To change or disable it,
set this before sourcing `.environmart`:

```shell
export ENVIRONMART_UPDATE_REMINDER_DAYS=7  # or 0 to disable
```
