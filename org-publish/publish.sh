#!/usr/bin/env bash

# Publishes Org files with emacs.
emacs --batch --chdir "${PWD}" --no-init-file --script init.el --load publish.el --kill
