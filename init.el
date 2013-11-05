;; Emacs init.el
;; Charles Lavery (https://charleslavery.com)
;; 2013

;; Turn off windowing elements
(if (fboundp 'tool-bar-mode) (tool-bar-mode 0))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode 0))
(if (fboundp 'fringe-mode) (fringe-mode 0))

;; remove startup message
(setq inhibit-startup-message t)

;; load packages from ~/.emacs.d/site-lisp
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

;; package.el
(package-initialize)

;; Additional package repositories
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))


;; Place customize variables in it's own file
(setq custom-file "~/.emacs.d/my-custom-variables.el")
(load custom-file)

;; Load packages from ~/.emacs.d
(add-to-list 'load-path user-emacs-directory)

;; load packages from ~/.emacs.d/site-lisp
(add-to-list 'load-path site-lisp-dir)

;; add each dir in site-lisp to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))


;;;;;; Defaults ;;;;;;

(require 'better-defaults)

(require 'my-defaults)

(require 'my-keybindings)

(require 'my-functions)


;;;;;; Mode Configuration ;;;;;;

(require 'init-mode-line)
(require 'init-orgmode)
(require 'init-ibuffer)
(require 'init-ido)

;; Languages
(require 'init-javascript)
(require 'init-python)
(require 'init-web-mode)


;;;;;; System Specific Init ;;;;;;

;; OS X
(setq is-mac (equal system-type 'darwin))
(when is-mac
  (require 'init-osx))

;; Windows
(setq is-windows (equal system-type 'windows-nt))
(when is-windows
  (require 'init-windows))


;;;;;; Packages ;;;;;;

(eval-after-load 'magit '(require 'init-magit))

(require 'autopair)

(require 'smex)
(smex-initialize)
(define-key global-map (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require 'multiple-cursors)

(require 'browse-kill-ring)
(define-key global-map (kbd "\C-x y") 'browse-kill-ring)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-<return>") 'ace-jump-mode)

(require 'highlight-indentation)
(add-hook 'python-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

(require 'expand-region)
(global-set-key (kbd "M-j") 'er/expand-region)

;; Flymake
(delete '(".+\\.scss$" flymake-scss-init) flymake-allowed-file-name-masks)
(setq scss-compile-at-save nil)


;;;;;; Theming ;;;;;;
(require 'appearance)


