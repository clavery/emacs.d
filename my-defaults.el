;; Charles Lavery's Emacs default settings
;; Anything not package or keybind related

;; Delete the selected region when starting typing
(delete-selection-mode 1)

;; show in progress keystrokes
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

;; Always display line and column numbers (in modeline)
(setq line-number-mode t)
(setq column-number-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; don't indent with \t Tabs
(set-default 'indent-tabs-mode nil)

;; use alot of memory
(setq gc-cons-threshold 20000000)

;; use ido-mode where possible
(setq ido-enable-flex-matching t)
(setq ido-mode 'both)
(setq ido-use-virtual-buffers t)
(ido-everywhere t)
(setq ido-max-directory-size 100000)

;; oh god turn off the bell
(setq ring-bell-function 'ignore)

;; autosave
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; allow narrowing
(put 'narrow-to-region 'disabled nil)

;; Auto refresh buffers if file changes
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(setq wdired-allow-to-change-permissions t)

;; allow repeatadly popping mark
(setq set-mark-command-repeat-pop t)

(provide 'my-defaults)
