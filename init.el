;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;
;;; Commentary:
;;
;; This file bootstraps the configuration, which is divided into
;; a number of other files.
;;
;;; Code:

(add-to-list 'load-path "~/.emacs.d/lib")

(require 'initialization)
(require 'builtins)
(require 'evil)
(require 'git)

;;----------------------------------------------------------------------------
(provide 'init)
;;; init.el ends here
