# emacs-demo
## Concept
Used to test different emacs configurations. The script starts emacs with the init-file from one of the directories, changes it's default location to that directory, downloads different packages to a subdirectory, and opens the init-file from that directory. This means you can test different emacs init-file versions without cluttering your main emacs user-init-directory.

Currently this works in Windows 10.
## Requirements
- [emacs 25 or later](https://www.gnu.org/software/emacs/). (But it might also work with emacs 24.4 and later. Depends on [use-package](https://github.com/jwiegley/use-package))
- [git](https://git-scm.com/)
- a working CMD-prompt with a path that includes git and emacs.

## How to use this
To try this out in windows:
    git clone https://github.com/sdaaish/emacs-demo.git
    cd emacs-demo
    .\demo.cmd demo1\init.el
    .\demo.cmd demo2\init.el
    and so on...

This starts emacs with the settings in the init-file. All changes stays in that directory and not your ~/.emacs.d.

[Info about emacs startup options](./emacs-startup-opts.md)

## Scripts
### demo.cmd
*Syntax*: `demo.cmd <demo[1-n]\init.el`

## Emacs config-dirs
### demo1
Plain emacs config with `use-package`. Demonstrates how to load packages from scratch with use-package.
A very basic config to start with.

### demo2
Downloads "Helm" and "Helm-Google".

### demo3
For testing of "Company mode".

### demo[n]
And you can ofcourse create your own directories with your config. But the script currently requires the directories to be called *demo[n]*.
