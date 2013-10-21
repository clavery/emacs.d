(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq inhibit-startup-message t)


(package-initialize)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))

;; check if the packages is installed; if not, install it.
(mapc
 (lambda (package)
   (or (package-installed-p package)
       (if (y-or-n-p (format "Package %s is missing. Install it? " package)) 
           (package-install package))))
 '(color-theme-molokai dired-details evil git-commit-mode
                       gitignore-mode magit org
                       smex undo-tree js2-mode autopair))


(require 'autopair)
(autopair-global-mode)

(setq custom-file "~/.emacs.d/my-custom-variables.el")
(load custom-file)

(add-to-list 'load-path user-emacs-directory)

(require 'server)
(unless (server-running-p)
  (server-start))

(require 'better-defaults)

(require 'appearance)

(require 'keybindings)

(require 'orgmode)

;; evil mode
(require 'evil)
(evil-mode 1)
(setq-default evil-shift-width 2)

; show in progress keystrokes
(setq echo-keystrokes 0.1)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; Show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

(set-default 'indent-tabs-mode nil)

; memory
(setq gc-cons-threshold 20000000)

(setq ido-enable-flex-matching t)
(setq ido-mode 'both)
(setq ido-use-virtual-buffers t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)

; turn off bell
(setq ring-bell-function 'ignore)

; autosave
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(put 'narrow-to-region 'disabled nil)


;; dired
;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(setq wdired-allow-to-change-permissions t)

(require 'smex)
(smex-initialize)

(require 'buffers)

(require 'diminish)
(eval-after-load "filladapt" '(diminish 'filladapt-mode))
