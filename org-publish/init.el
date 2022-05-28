;; This is the init-file that are loaded by emacs when the script demo.cmd are run.
;; All files used by this emacs-session (packages, themes, faces etc) should be stored in this directory.

;; This file is a good starting point for a new installations of emacs. Put the init-el in your ~/.emacs.d directory, or in Windows, %AppData%\.emacs.d

;; This version uses Straight as a package-manager with Use-package support instead ov the built-in Package-handling system.

;; This parts sets variables so files are stored in the init-file directory
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(setq default-directory (file-name-directory user-init-file))
(setq package-user-dir (concat (file-name-directory user-init-file) "../elpa/"))

;; use a separate file to store changes made by customize.
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file 'noerror)

;; We want to use UTF-8 as coding system
(prefer-coding-system       'utf-8)

;; install straight package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Also install use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Install org and tools
(use-package org
  :straight org-contrib)

(use-package htmlize)

(require 'ox-publish)
(setq org-publish-timestamp-directory (expand-file-name ".org-timestamps/" user-emacs-directory))
(setq org-publish-project-alist
      `(("Current-dir"
         :base-directory ,(file-name-directory "./")
         :base-extension "org"
         :publishing-directory ,(file-name-directory "./html/")
         :publishing-function org-html-publish-to-html
         :recursive nil
         )))

;; Print out startup time
(message "*** Startup time=%s ***" (emacs-init-time))

(provide 'init)
;;; init.el ends here
