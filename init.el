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
(require 'editor-defaults)
(require 'evil)

(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
