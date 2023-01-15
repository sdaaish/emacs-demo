;; This is the init-file that are loaded by Emacs from the script demo.{cmd,sh,ps1}.
;; All files used by this emacs-session (packages, themes, faces etc) should be stored in this directory.

;; This file is a good starting point for a new installations of emacs. Put the init-el in your ~/.emacs.d directory, or in Windows, %AppData%\.emacs.d

;; This parts sets variables so files are stored in the init-file directory
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(setq default-directory (file-name-directory user-init-file))
(setq package-user-dir (concat (file-name-directory user-init-file) "../elpa/"))

;; use a separate file to store changes made by customize.
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file 'noerror)

;; Winner mode handles window-changes
(winner-mode t)

;; We want to use UTF-8 as coding system
(set-language-environment "utf-8")

;; Set what kind of archives should be used
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Make sure `use-package' is loaded.
(eval-when-compile
  (require 'use-package))

;; Use Vertico for vertical navigation.
(use-package vertico
  :ensure t
  :config (vertico-mode))

;; Orderless searches in a fuzzy manner.
(use-package orderless
  :ensure t
  :config (setq completion-styles '(orderless basic)
		completion-category-defaults nil
		completion-category-overrides '((file (styles partial-completion)))))

;; Use Consult to manage buffers and others.
(use-package consult
  :ensure t
  :bind
  ("C-x b" . consult-buffer))

;; Add more info in the mini-buffer with Marginalia.
(use-package marginalia
  :ensure t
  :init (marginalia-mode)
  :bind (
	 :map minibuffer-local-map
	      ("M-A" . marginalia-cycle)))

;; Embark adds a context menu to commands. 
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Used together with Embark and Consult.
(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package modus-themes
  :ensure t
  :init (load-theme 'modus-vivendi-tinted t))

;; Set a default font, and change also the current frame.
(set-face-attribute 'default t :font "Lucida Console 12")
(set-frame-font "Lucida Console 12" nil t)

;; Print out startup time
(message "*** Startup time=%s ***" (emacs-init-time))
