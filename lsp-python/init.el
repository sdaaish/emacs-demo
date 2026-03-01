;;; INIT --- Summary
;;
;; Author: Stig Dahl <stig@charlottendal.net>
;; Created: 2025-02-01
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;; Set the initial frame size depending on the monitor resolution.
(defun setup-frame-size (p1 p2 x y)
  "Set the frame size when Emacs starts up."
  (set-frame-position nil p1 p2)
  (set-frame-width nil x)
  (set-frame-height nil y))

;; Setup a smaller window when starting
(setup-frame-size 100 20 50 30)

(add-hook 'window-size-change-functions
          #'frame-hide-title-bar-when-maximized)

;; Install packages at first start
(message "Installing packages from ELPA/MELPA....")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
 (package-refresh-contents))

;; Custom settings
(if (>= emacs-major-version 29)
    (require 'bind-key))


(unless (directory-name-p (expand-file-name ".cache" (file-name-parent-directory user-emacs-directory)))
  (make-directory (expand-file-name ".cache" (file-name-parent-directory user-emacs-directory)) t)
  (setq user-emacs-directory (expand-file-name ".cache" (file-name-parent-directory user-emacs-directory))))

;; Settings from daviwil
(setq
 visible-bell t
 inhibit-startup-message t
 auto-save-default nil
 make-backup-files nil
 set-mark-command-repeat-pop t
 large-file-warning-threshold nil
 vc-follow-symlinks t
 ad-redefinition-action 'accept
 global-auto-revert-non-file-buffers t
 native-comp-async-report-warnings-errors nil
 mode-line-compact t
 display-time-24hr-format t
 fringe-mode 10)

;; Core modes
(auto-save-visited-mode 1)     ;; Auto-save files at an interval
(column-number-mode 1)         ;; Show column number on mode line
(display-time-mode 1)          ;; Display time in mode line / tab bar
(fido-vertical-mode 1)         ;; Improved vertical minibuffer completions
(global-auto-revert-mode 1)    ;; Refresh buffers with changed local files
(global-visual-line-mode 1)    ;; Visually wrap long lines in all buffers
(menu-bar-mode 1)
(savehist-mode 1)              ;; Save minibuffer history
(scroll-bar-mode 0)            ;; Hide the scroll bar
(size-indication-mode 1)
(tab-bar-history-mode 1)       ;; Remember previous tab window configurations
(tool-bar-mode 0)              ;; Hide the tool bar
(xterm-mouse-mode 1)           ;; Enable mouse events in terminal Emacs
(winner-mode 1)

;; Tabs to spaces
(setq-default indent-tabs-mode nil
	            tab-width 2)

;; Display line numbers in programming modes
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Make icomplete slightly more convenient
(keymap-set icomplete-fido-mode-map "M-h" 'icomplete-fido-backward-updir)
(keymap-set icomplete-fido-mode-map "TAB" 'icomplete-force-complete)

;; Delete trailing whitespace before saving buffers
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file t))

;; Create unique buffer names
(require 'uniquify)

;; Use Modus Themes
;;(require 'modus-themes)
(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs t
      modus-themes-org-blocks 'tinted-background
      modus-themes-variable-pitch-ui t
      modus-themes-hl-line '(accented intense)
      modus-themes-paren-match '(bold intense)
      modus-themes-mixed-fonts t
      modus-themes-prompts '(regular bold)
      modus-themes-completions
      '((matches . (extrabold underline))
        (selection . (semibold italic)))
      modus-themes-mode-line '(moody borderless accented)
      modus-themes-subtle-line-numbers t
      modus-themes-headings
      '((0 . (background overline 1.5))
	      (1 . (background overline 1.3))
        (2 . (overline rainbow 1.2))
        (3 . (overline 1.1))
        (t . (monochrome))))

;; Enable both dark and light theme. Swicth with Shift-F5
(load-theme 'modus-operandi t t)
(load-theme 'modus-vivendi t t)
(enable-theme 'modus-vivendi)
(define-key global-map (kbd "S-<f5>") #'modus-themes-toggle)

;; Use larger fonts
(when (display-graphic-p)
  (set-face-attribute 'default nil
                      :weight 'normal
                      :height 140)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil
                      :weight 'normal
                      :height 140)

  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil
                      :height 120
                      :weight 'normal))

;; Shortcut to open the config file
(defun open-user-init-file ()
  "Finds Emacs configuration key"
  (interactive)
  (find-file-other-window user-init-file))

(bind-key "<f8> i" 'open-user-init-file)

;;Install other packages
(unless (package-installed-p 'helpful)
  (package-vc-install 'helpful))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Install dependencies for Python development
(unless (package-installed-p 'yasnippet)
  (package-vc-install 'yasnippet))
(require 'yasnippet)

(unless (package-installed-p 'yasnippet-snippets)
  (package-vc-install 'yasnippet-snippets))

(unless (package-installed-p 'lsp-mode)
  (package-vc-install 'lsp-mode))

(unless (package-installed-p 'lsp-pyright)
  (package-install 'lsp-pyright))

(unless (package-installed-p 'company)
  (package-vc-install 'company))
(require 'company)
(global-company-mode 1)

(unless (package-installed-p 'which-key)
  (package-vc-install 'which-key))
(require 'which-key)
(which-key-mode 1)

(unless (package-installed-p 'envrc)
  (package-vc-install 'envrc))

(unless (package-installed-p 'dap-mode)
  (package-vc-install 'dap-mode))

(unless (package-installed-p 'envrc)
  (package-vc-install 'envrc))

;; Initial size of the frame, if wide screen, center the frame.
;; Else, maximize it (not full screen).

(cond ((>= (nth 3 (assq 'geometry (frame-monitor-attributes))) 5000)
       (setup-frame-size 1000 20 200 40))
      ((>= (nth 3 (assq 'geometry (frame-monitor-attributes))) 3000)
       (setup-frame-size 600 20 200 50))
      (t (toggle-frame-maximized nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Emacs setup for Python, from https://blog.serghei.pl/posts/emacs-python-ide/

(with-eval-after-load 'yasnippet
  (yas-reload-all))

;; Only if you use `flymake-mode'.
(with-eval-after-load 'flymake
  (define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error))

;; Set LSP keymap prefix.
(setopt lsp-keymap-prefix "C-c l")

;; Shut down LSP server after close all buffers associated with the server.
(setopt lsp-keep-workspace-alive nil)

;; Configure LSP UI enhancements.
(setopt lsp-headerline-breadcrumb-segments
        '(path-up-to-project
          file
          symbols))

(with-eval-after-load 'lsp-ui
  ;; Remap `xref-find-definitions' (bound to M-. by default).
  (define-key lsp-ui-mode-map
              [remap xref-find-definitions]
              #'lsp-ui-peek-find-definitions)

  ;; Remap `xref-find-references' (bound to M-? by default).
  (define-key lsp-ui-mode-map
              [remap xref-find-references]
              #'lsp-ui-peek-find-references))

;; Configure LSP mode for enhanced experience.
(with-eval-after-load 'lsp-mode
  ;; Remap `lsp-treemacs-errors-list' (bound to C-c l g e).
  (define-key lsp-mode-map
              [remap lsp-treemacs-errors-list]
              #'consult-lsp-diagnostics)

  ;; Remap `xref-find-apropos' (bound to C-c l g a).
  (define-key lsp-mode-map
              [remap xref-find-apropos]
              #'consult-lsp-symbols)

  ;; Enable `which-key-mode' integration for LSP.
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; (defmacro company-backend-for-hook (hook backends)
;;   `(add-hook ,hook (lambda ()
;;                      (set (make-local-variable 'company-backends)
;;                           ,backends))))

(defun setup-lsp-completion ()
  (setq-local company-backends
              '((company-capf :with company-yasnippet)
                company-dabbrev-code)))

(add-hook 'lsp-completion-mode-hook #'setup-lsp-completion)

(setq python-indent-offset 4
      python-indent-guess-indent-offset 4
      python-indent-guess-indent-offset-verbose nil)

(defun setup-python-environment ()
  "Setup a Python development environment in the current buffer."
  ;; Update the current buffer's environment.
  (envrc--update)

  ;; Enable YASnippet mode.
  (yas-minor-mode 1)

  ;; Auto configure dap minor mode.
  (require 'treemacs)
  (require 'lsp-treemacs)

  ;; Prevent `lsp-pyright' start in multi-root mode.
  ;; This must be set before the package is loaded.
  (setq-local lsp-pyright-multi-root nil)

  ;; Enable LSP support in Python buffers.
  (require 'lsp-pyright)
  (lsp-deferred)

  ;; Enable DAP support in Python buffers.
  (require 'dap-mode)
  (require 'dap-python)
  (setq-local dap-python-debugger 'debugpy)
  (setq dap-auto-configure-mode t)
  (dap-mode 1))

;; Configure hooks after `python-mode' is loaded.
(add-hook 'python-mode-hook #'setup-python-environment)

;; Setup buffer-local direnv integration for Emacs.
(when (executable-find "direnv")
  ;; `envrc-global-mode' should be enabled after other global minor modes,
  ;; since each prepends itself to various hooks.
  (add-hook 'after-init-hook #'envrc-global-mode))


(provide 'init)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here
