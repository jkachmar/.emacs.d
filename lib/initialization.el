;;; initialization.el --- Initialization.  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; This module configures settings, sets variables, and installs packages
;; that should come before any other additional configuration.
;;
;;; Code:

;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter.
;;----------------------------------------------------------------------------
(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;;----------------------------------------------------------------------------
;; Misc. settings that must be applied before package management.
;;----------------------------------------------------------------------------

;; Some settings will be macOS-specific; it's good to set this early.
(defconst *is-a-mac* (eq system-type 'darwin))

;; Don't litter the 'init.el' file with customizations.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;----------------------------------------------------------------------------
;; Package management.
;;----------------------------------------------------------------------------

;; 'straight.el' boilerplate.
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

;; Install 'use-package' from 'straight' and integrate the two.
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;;----------------------------------------------------------------------------
;; Packages that should be installed and configured before anything else.
;;----------------------------------------------------------------------------
(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

;;----------------------------------------------------------------------------
(provide 'initialization)
;;; initialization.el ends here
