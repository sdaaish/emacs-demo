;; This is the init-file that are loaded by emacs when the script demo.cmd are run.
;; All files used by this emacs-session (packages, themes, faces etc) should be stored in this directory.

;; This file is a good starting point for a new installations of emacs. Put the init-el in your ~/.emacs.d directory, or in Windows, %AppData%\.emacs.d

;; This parts sets variables so files are stored in the init-file directory
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(setq default-directory (file-name-directory user-init-file))
(setq package-user-dir (concat (file-name-directory user-init-file) "elpa/"))

;; use a separate file to store changes made by customize.
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file 'noerror)

;; Winner mode handles window-changes
(winner-mode t)

;; We want to use UTF-8 as coding system
(prefer-coding-system       'utf-8)

;; Set what kind of archives should be used
(setq package-enable-at-startup nil)
(setq package-archives nil)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Print out startup time
(message "*** Startup time=%s ***" (emacs-init-time))
