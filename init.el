;; cop&mod from https://github.com/arecker/emacs.d
(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")))

(setq debug-on-error 't
      network-security-level 'low)

(defun sim/package-init ()
  "Initialize the package manager and install use-package."
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)))

(defun sim/load-config ()
  "Tangle configuration and load it"
  (let ((config (concat (file-name-as-directory user-emacs-directory) "README.org")))
    (if (file-exists-p config)
	(org-babel-load-file config)
      (warn (concat config " not found - not loading")))))

(sim/package-init)
(sim/load-config)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-default-notes-file (concat org-directory "/notes.org"))
 '(org-directory "~/org")
 '(org-export-html-postamble nil)
 '(org-hide-leading-stars t)
 '(org-mobile-directory "~/org")
 '(org-startup-folded (quote overview))
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (company-quickhelp company-math cmake-mode clang-format company-c-headers company-irony company-statistics flycheck-irony flycheck swiper ob-ipython org-noter org-download noflet org-bullets company-auctex epresent rainbow-mode which-key flyspell-correct-ivy autopair multi-term org-pdfview pdf-tools origami multiple-cursors hungry-delete beacon undo-tree ace-window powerline doom-themes use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
