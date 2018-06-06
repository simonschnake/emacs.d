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
