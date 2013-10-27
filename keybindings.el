(define-key global-map (kbd "RET") 'newline-and-indent)

(define-key global-map (kbd "\C-z") 'evil-emacs-state)

(define-key global-map (kbd "\C-x k") 'kill-this-buffer)

(define-key global-map (kbd "\C-x g") 'magit-status)


(defun unix-werase-or-kill (arg)
      (interactive "*p")
      (if (and transient-mark-mode
        	   mark-active)
          (kill-region (region-beginning) (region-end))
        (backward-kill-word arg)))

(define-key global-map (kbd "\C-w") 'unix-werase-or-kill)

(define-key global-map (kbd "\C-s") 'isearch-forward-regexp)
(define-key global-map (kbd "\C-r") 'isearch-backward-regexp)

; multiple cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

(provide 'keybindings)
