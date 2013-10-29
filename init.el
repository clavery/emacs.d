(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'fringe-mode) (fringe-mode 0))

(setq inhibit-startup-message t)

(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(package-initialize)
(add-to-list 'package-archives 
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(require 'autopair)
(autopair-global-mode)

(setq custom-file "~/.emacs.d/my-custom-variables.el")
(load custom-file)

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path site-lisp-dir)

; load site lisp subdirs
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(setq is-mac (equal system-type 'darwin))
(when is-mac
  (exec-path-from-shell-initialize)
  (setq mac-command-modifier 'meta))
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
;(evil-mode 1)
;(setq-default evil-shift-width

(delete-selection-mode 1)

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
(ido-everywhere 1)

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
(setq my-mode-line-evil-status
      '(:eval (cond 
               ((evil-normal-state-p)
                (propertize " <N> " 'face 'font-lock-warning-face))
               ((evil-insert-state-p)
                (propertize " <I> " 'face 'font-lock-warning-face))
               ((member major-mode evil-emacs-state-modes)
                (propertize " <E> " 'face 'font-lock-warning-face))
               ((evil-emacs-state-p)
                (propertize " <E> " 'face 'font-lock-warning-face))
               (t
                (propertize " <?> " 'face 'font-lock-warning-face)))))


(setq my-mode-line-format
  (list
     " "

     my-mode-line-evil-status

    
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
              (concat ""  (propertize "Mod"
                             'face 'font-lock-variable-name-face
                             'help-echo "Buffer has been modified"))))

    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
              (concat " "  (propertize "RO"
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

    " "

    '(:eval global-mode-string)
    ))

(setq-default mode-line-format my-mode-line-format)
(setq mode-line-format my-mode-line-format)
(setq evil-mode-line-format 'nil)

(require 'javascript)

(require 'my-python)
(require 'multiple-cursors)

(require 'browse-kill-ring)
(define-key global-map (kbd "\C-x y") 'browse-kill-ring)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-<return>") 'ace-jump-mode)

(setq magit-status-buffer-switch-function 'switch-to-buffer)

(projectile-global-mode)
(setq projectile-enable-caching t)

(require 'flx-ido)
(flx-ido-mode 1)
(setq ido-use-faces nil)
;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)


; sort ido filelist by mtime instead of alphabetically
(defun ido-sort-mtime ()
  (setq ido-temp-list
        (sort ido-temp-list 
              (lambda (a b)
                (time-less-p
                 (sixth (file-attributes (concat ido-current-directory b)))
                 (sixth (file-attributes (concat ido-current-directory a)))))))
  (ido-to-end  ;; move . files to end (again)
   (delq nil (mapcar
              (lambda (x) (and (char-equal (string-to-char x) ?.) x))
              ido-temp-list))))
(add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
(require 'web)

(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(desktop-save-mode 1)

(setq set-mark-command-repeat-pop t)

(require 'highlight-indentation)
(add-hook 'python-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

(require 'dash-at-point)
(add-to-list 'dash-at-point-mode-alist '(python-mode . "python2"))
(add-to-list 'dash-at-point-mode-alist '(js2-mode . "js"))

(require 'auto-complete-config)
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'web-mode)

