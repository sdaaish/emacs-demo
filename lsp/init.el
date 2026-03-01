;; Early init
;; This parts sets variables so files are stored in the init-file directory

;; [[file:init.org::*Early init][Early init:1]]
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(setq default-directory (file-name-directory user-init-file))
(setq package-user-dir (concat (file-name-directory user-init-file) "../elpa/"))

;; use a separate file to store changes made by customize.
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file 'noerror)

;; We want to use UTF-8 as coding system
(set-language-environment "utf-8")
;; Early init:1 ends here

;; Install straight package manager
;; Use =straight= as package-manager instead for the built in.

;; [[file:init.org::*Install straight package manager][Install straight package manager:1]]
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
;; Install straight package manager:1 ends here

;; Also install use-package
;; =Use-package= still works with =straight=, lets use that for simplified configuration.

;; [[file:init.org::*Also install use-package][Also install use-package:1]]
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
;; Also install use-package:1 ends here

;; GCMH
;; Manage garbage collection (=gh=) automatically.

;; [[file:init.org::*GCMH][GCMH:1]]
(use-package gcmh
  :diminish gcmh-mode
  :config (gcmh-mode 1))
;; GCMH:1 ends here

;; Syntax checking with the modern version of flymake

;; [[file:init.org::*Syntax checking with the modern version of flymake][Syntax checking with the modern version of flymake:1]]
(use-package flycheck
  :config
  (global-flycheck-mode t))
;; Syntax checking with the modern version of flymake:1 ends here

;; Navigation with avy

;; [[file:init.org::*Navigation with avy][Navigation with avy:1]]
(use-package avy-flycheck
  :config
  (avy-flycheck-setup))
;; Navigation with avy:1 ends here

;; Snippets

;; [[file:init.org::*Snippets][Snippets:1]]
(use-package yasnippet)
(use-package yasnippet-snippets)
;; Snippets:1 ends here

;; Language Server Protocol
;; Has built-in support for bash. Needs bash-language-server, installed separately

;; [[file:init.org::*Language Server Protocol][Language Server Protocol:1]]
(use-package lsp-mode
  :commands lsp
  :hook
  ((powershell-mode sh-mode) . lsp)
  (lsp-mode . lsp-enable-which-key-integration))
;; Language Server Protocol:1 ends here

;; LSP for powershell

;; [[file:init.org::*LSP for powershell][LSP for powershell:1]]
(use-package powershell)
(use-package ob-powershell)
;; LSP for powershell:1 ends here

;; UI for LSP

;; [[file:init.org::*UI for LSP][UI for LSP:1]]
(use-package lsp-ui
  :commands lsp-ui-mode)
;; UI for LSP:1 ends here

;; Ivy

;; [[file:init.org::*Ivy][Ivy:1]]
(use-package ivy
  :config (ivy-mode 1))
;; Ivy:1 ends here

;; Ivy for LSP

;; [[file:init.org::*Ivy for LSP][Ivy for LSP:1]]
(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)
;; Ivy for LSP:1 ends here

;; Which key

;; [[file:init.org::*Which key][Which key:1]]
(use-package which-key
  :config
  (which-key-mode))
;; Which key:1 ends here

;; Autocompletion with Company

;; [[file:init.org::*Autocompletion with Company][Autocompletion with Company:1]]
(use-package company
  :custom (company-minimum-prefix-length 1)
  (company-idle-time 0.2))

(use-package company-lsp
  :config
  (push 'company-lsp company-backends))
;; Autocompletion with Company:1 ends here

;; Performance
;; Increase buffer to read from LSP process.

;; [[file:init.org::*Performance][Performance:1]]
(setq read-process-output-max (* 1024 1024))
;; Performance:1 ends here

;; Org mode

;; [[file:init.org::*Org mode][Org mode:1]]
(setq org-src-preserve-indentation t)
;; Org mode:1 ends here

;; Load modus theme
;; =Modus themes= is a collection  of highly customizable themes.

;; [[file:init.org::*Load modus theme][Load modus theme:1]]
(use-package modus-themes
  :ensure t
  :init (load-theme 'modus-vivendi-tinted t))
;; Load modus theme:1 ends here

;; Set a default font.
;; Set a default font, and change also the current frame.

;; [[file:init.org::*Set a default font.][Set a default font.:1]]
(set-face-attribute 'default t :font "Lucida Console 12")
(set-frame-font "Lucida Console 12" nil t)
;; Set a default font.:1 ends here

;; The end
;; Print out startup time.

;; [[file:init.org::*The end][The end:1]]
(message "*** Startup time=%s ***" (emacs-init-time))
;; The end:1 ends here
