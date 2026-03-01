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
(setup-frame-size 80 20 40 20)

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
(menu-bar-mode 1)              ;; Show the menu-bar. It is useful and don't take much vertical space.
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

(unless (package-installed-p 'company)
  (package-vc-install 'company))
(require 'company)
(global-company-mode 1)

(unless (package-installed-p 'which-key)
  (package-vc-install 'which-key))
(require 'which-key)
(which-key-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EAT is a emulating terminal for Emacs. (Emulate A Terminal).
;; https://codeberg.org/akib/emacs-eat#headline-3

(unless (package-installed-p 'eat)
  (package-vc-install 'eat))

;; For `eat-eshell-mode'.
(add-hook 'eshell-load-hook #'eat-eshell-mode)

;; For `eat-eshell-visual-command-mode'.
;;(add-hook 'eshell-load-hook #'eat-eshell-visual-command-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Only if you use `flymake-mode'.
(with-eval-after-load 'flymake
  (define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initial size of the frame, if wide screen, center the frame.
;; Else, maximize it (not full screen).

(cond ((>= (nth 3 (assq 'geometry (frame-monitor-attributes))) 5000)
       (setup-frame-size 1000 20 200 40))
      ((>= (nth 3 (assq 'geometry (frame-monitor-attributes))) 3000)
       (setup-frame-size 600 20 200 50))
      (t (toggle-frame-maximized nil)))

(provide 'init)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init.el ends here
