# emacs-demo
## Concept
Used to test different Emacs configurations.
The script starts Emacs with the init-file from one of the directories, changes it's default location to that directory, downloads different packages to a subdirectory, and opens the init-file from that directory. This means you can test different Emacs init-file versions without cluttering your main emacs user-init-directory.

Currently this works in Windows 10. Other versions not tested, but any Windows version will probably work.
## Requirements
- [GNU/Emacs 25 or later](https://www.gnu.org/software/emacs/). (But it might also work from Emacs 24.4, and derivates. Depends on [use-package](https://github.com/jwiegley/use-package))
- [Git](https://git-scm.com/)
- a working environment with a path that includes _git_ and _emacs_ executables.
- `emacs.exe` must be in the path for the scripts to work

## How to use this
To try this out in Windows, from either the command-shell or powershell.
### CMD-prompt
```
git clone https://github.com/sdaaish/emacs-demo.git
cd emacs-demo
.\demo.cmd demo1\init.el
.\demo.cmd demo2\init.el
...
```
### Powershell
```
git clone https://github.com/sdaaish/emacs-demo.git
cd emacs-demo
.\demo.ps1 demo1\init.el
.\demo.ps1 demo2\init.el
...
```
### Results
This starts Emacs with the settings in the init-file. All changes stays in that directory and not your `~/.emacs.d`.

## Emacs startup options
[Info about Emacs startup options](./emacs-startup-opts.md)

## Scripts
### demo.cmd
**Syntax**: `.\demo.cmd <demo[1-n]>\init.el`

### demo.ps1
**Syntax**: `.\demo.ps1 <demo[1-n]>\init.el`

## Emacs config-dirs
### demo1
Plain emacs config with `use-package`. Demonstrates how to load packages from scratch with use-package.
A very basic config to start with. (./demo1/init.el)

### demo2
Downloads `helm and `helm-google`. (./demo2/init.el)

### demo3
Preconfigured for testing of `company mode`. (./demo3/init.el)

### demo[n]
And you can of course create your own directories with your config. But the script currently requires the init-file to be called `init.el`. The directory can be called anything.

## Problems
The initial startup of emacs is slow, since it downloads packages at startup. But the second time it will be faster.

## Todo
Store emacs packages in a common folder to make startup faster when one switch between different configurations.

## Other
There is also other configurations of emacs that you can try out if you don't want to start from scratch. Foe example [Super-emacs](https://github.com/myTerminal/super-emacs).
