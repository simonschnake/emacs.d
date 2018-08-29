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

(setq readme-org "~/.emacs.d/README.org"
      readme-elc (concat (file-name-sans-extension readme-org) ".elc"))

(defun readme-elc-is-old ()
  (time-less-p (sim/file-modification-time readme-elc)
               (sim/file-modification-time readme-org)))

(defun recompile-readme-org ()
  (interactive)
  (let ((old-init-file-debug init-file-debug)
        (init-file-debug nil))
    (require 'ob-tangle)
    (org-babel-load-file readme-org t)
    (setq init-file-debug old-init-file-debug)))

;; If readme.org is newer than readme.elc, then load .org and show a
;; message that elc is out of date. Don't load elc anyway if in
;; init-file-debug mode
(if (or init-file-debug (readme-elc-is-old))
    (progn
      (require 'ob-tangle)
      (org-babel-load-file readme-org)
      (message "readme.elc older than readme.org. Update with M-x recompile-readme-org"))
  (load-file readme-elc))
