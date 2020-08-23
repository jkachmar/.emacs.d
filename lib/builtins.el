;;; builtins.el --- Improve built-in defaults.  -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;; This module improves over Emacs' built-in defaults.
;;
;; It should avoid installing external packages, if at all possible, and
;; defer those responsibilities to other more specialized modules in this
;; configuration.
;;
;;; Code:

;;----------------------------------------------------------------------------
;; Basic settings which should be overridden by default.
;;
;; Normally we wouldn't need to dedicate an entire module to handling this
;; sort of garbage in a text editor, but Emacs is old and people are
;; apparently afraid of change.
;;----------------------------------------------------------------------------

;; Accept 'y' and 'n' in lieu of 'yes' or 'no'.
(defalias 'yes-or-no-p 'y-or-n-p)

;; General variables that should be set everywhere.
(setq 
  ;; No need to see GNU agitprop.
  inhibit-startup-screen t
  ;; I have better things to do than find files with my mouse.
  use-file-dialog nil
  ;; We have a minibuffer for a reason.
  use-dialog-box nil
  ;; Double-spaces after periods is morally wrong.
  sentence-end-double-space nil
  ;; Never ding at me, ever.
  ring-bell-function 'ignore
  ;; Prompts should go in the minibuffer, not in a GUI.
  use-dialog-box nil
  ;; Fix undo in commands affecting the mark.
  mark-even-if-inactive nil
  ;; Let C-k delete the whole line.
  kill-whole-line t
  ;; Search should be case-sensitive by default.
  case-fold-search nil
  ;; Don't litter the file system with .#<file> lockfiles.
  create-lockfiles nil
  ;; Don't litter the file system backup files.
  make-backup-files nil
  ;; Don't litter the filesystem with autosaves.
  auto-save-default nil
  ;; Make sure we actually want to kill Emacs.
  confirm-kill-emacs #'yes-or-no-p
  )

;; Settings which become buffer-local variables when set, and which therefore
;; must be set by default.
(setq-default 
  ;; Use spaces for indentation everywhere by default.
  indent-tabs-mode nil
  ;; Pretty much everything uses 2 space tabs these days; the exceptions can
  ;; be overridden with their own hooks.
  tab-width 2
  )

;; macOS-specific settings.
(when *is-a-mac*
  ;; NOTE: CMD is bound to Meta on Yamamoto Mitsuharu's Mac port; on other
  ;; versions it's bound to "s" and this constant should be adjusted
  ;; accordingly.
  (global-set-key (kbd "M-q") 'save-buffers-kill-emacs)
  )

;; Make is terrible and requires tabs, and is common enough that this override
;; should be set by default as well.
(add-hook 'makefile-mode-hook
          (lambda ()
            (setq-local indent-tabs-mode t)))

;; UTC-8 should _always_ be the default.
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; It's absolutely ridiculous that these aren't turned on by default in a
;; text editor.
(delete-selection-mode t)
(global-display-line-numbers-mode t)
(column-number-mode)
(show-paren-mode)

;;----------------------------------------------------------------------------
;; Visual settings.
;;----------------------------------------------------------------------------

;; GUI window chrome is wasteful and unpleasant to look at.
(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (fringe-mode -1))

;; Text scaling, with reasonaable global shortcuts.
;;
;; NOTE: Purcell has 'default-text-scale'; maybe look at that.
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Emacs 27 has fast current-line highlighting, but this can clash with
;; 'vterm' or 'ivy' buffers, so it should only be enabled in programming or
;; text modes.
(require 'hl-line)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'text-mode-hook #'hl-line-mode)
(set-face-attribute 'hl-line nil :background "gray26")

;;----------------------------------------------------------------------------
(provide 'builtins)
;;; builtins.el ends here
