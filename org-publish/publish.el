;;; Publishes 
(require 'ox-publish)
(setq org-export-html-validation-link nil)

;; Publish org-files
(org-publish-project "Current-dir")
(kill-emacs)

(provide 'publish)
;;; publish.el ends here
