;;; -*- lexical-binding: t; -*-
;; stolen and modified from https://github.com/Kaali/vj-emacs-0x12
;; Disable package initialize at startup. The commented line below is
;; required for really disabling it.

;; (package-initialize)
(setq package-enable-at-startup nil)

(defun sim/file-modification-time (filename)
  "The modification time of a file."
  (if (file-exists-p filename)
      (file-attribute-modification-time (file-attributes filename))
    '(0 0 0 0)))

(setq emacs-org "~/.emacs.d/emacs.org"
      emacs-elc (concat (file-name-sans-extension emacs-org) ".elc"))

(defun emacs-elc-is-old ()
  (time-less-p (sim/file-modification-time emacs-elc)
               (sim/file-modification-time emacs-org)))

(defun recompile-emacs-org ()
  (interactive)
  (let ((old-init-file-debug init-file-debug)
        (init-file-debug nil))
    (require 'ob-tangle)
    (org-babel-load-file emacs-org t)
    (setq init-file-debug old-init-file-debug)))

;; If emacs.org is newer than emacs.elc, then load .org and show a
;; message that elc is out of date. Don't load elc anyway if in
;; init-file-debug mode
(if (or init-file-debug (emacs-elc-is-old))
    (progn
      (require 'ob-tangle)
      (org-babel-load-file emacs-org)
      (message "emacs.elc older than emacs.org. Update with M-x recompile-emacs-org"))
  (load-file emacs-elc))
