(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(fringe-mode 0)

(setq inhibit-startup-message t)


(package-initialize)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

;; check if the packages is installed; if not, install it.
;;(dired-details evil git-commit-mode gitignore-mode magit org smex undo-tree js2-mode autopair))



(require 'autopair)
(autopair-global-mode)

(setq custom-file "~/.emacs.d/my-custom-variables.el")
(load custom-file)

(add-to-list 'load-path user-emacs-directory)

(require 'server)
;(and (>= emacs-major-version 23) (defun server-ensure-safe-dir (dir) "Noop" t))
;(unless (server-running-p)
;  (server-start))

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

(require 'minimap)
(setq minimap-window-location 'right)

;; Mode line
(setq djr-mode-line-evil-status
      '(:eval (cond 
               ((evil-normal-state-p)
                (propertize " <N> " 'face 'mode-line-evil-status-normal-face))
               ((evil-insert-state-p)
                (propertize " <I> " 'face 'mode-line-evil-status-insert-face))
               ((member major-mode evil-emacs-state-modes)
                (propertize " <E> " 'face 'mode-line-evil-status-normal-face))
               ((evil-emacs-state-p)
                (propertize " <E> " 'face 'mode-line-evil-status-emacs-face))
               (t
                (propertize " <?> " 'face 'mode-line-evil-status-emacs-face)))))
(setq my-mode-line-format
  (list
     " "

     djr-mode-line-evil-status

    
    ;; the buffer name; the file name as a tool tip
    '(:eval (propertize "%b " 'face 'font-lock-keyword-face
        'help-echo (buffer-file-name)))

    ;; line and column
    "(" ;; '%02' to set to 2 chars at least; prevents flickering
      (propertize "%02l" 'face 'font-lock-type-face) ","
      (propertize "%02c" 'face 'font-lock-type-face) 
    ") "

    ;; relative position, size of file
    "["
    (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
    "/"
    (propertize "%I" 'face 'font-lock-constant-face) ;; size
    "] "

    ;; the current major mode for the buffer.
    "["

    '(:eval (propertize "%m" 'face 'font-lock-string-face
              'help-echo buffer-file-coding-system))
    "] "


    "["
    ;; was this buffer modified since the last save?
    '(:eval (when (buffer-modified-p)
              (concat ","  (propertize "Mod"
                             'face 'font-lock-warning-face
                             'help-echo "Buffer has been modified"))))

    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
              (concat ","  (propertize "RO"
                             'face 'font-lock-type-face
                             'help-echo "Buffer is read-only"))))  
    "] "

    ;; add the time, with the date and the emacs uptime in the tooltip
    '(:eval (propertize (format-time-string "%H:%M")
              'help-echo
              (concat (format-time-string "%c; ")
                      (emacs-uptime "Uptime:%hh"))))
    ;; i don't want to see minor-modes; but if you want, uncomment this:
    ;; minor-mode-alist  ;; list of minor modes
    ))

(setq-default mode-line-format my-mode-line-format)
(setq mode-line-format my-mode-line-format)
(setq evil-mode-line-format 'nil)
