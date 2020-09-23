;;; evil.el --- Evil-mode and immediately useful accompaniments.  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:

;;----------------------------------------------------------------------------
;; Evil mode.
;;----------------------------------------------------------------------------
;; 'evil-collection' assumes the following settings, but it's possible that
;; other packages may load 'evil' and mess with this (global variables,
;; amirite?).
(setq
  evil-want-integration t 
  evil-want-keybinding nil)

(use-package evil
  :config 
  (evil-mode t))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  ;; Don't automatically load evil-collection's overrides for all modes.
  ;;
  ;; This is mostly to allow me to see what evil-collection does and does not
  ;; modify while I'm still figuring things out.
  (setq evil-collection-mode-list
        '(dired
          magit)))

(use-package evil-magit
  :after (evil magit))

;;----------------------------------------------------------------------------
(provide 'evil)
;;; evil.el ends here
