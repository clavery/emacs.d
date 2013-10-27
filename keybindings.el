(define-key global-map (kbd "RET") 'newline-and-indent)

(define-key global-map (kbd "\C-z") 'evil-emacs-state)

(define-key global-map (kbd "\C-x k") 'kill-this-buffer)

(define-key global-map (kbd "\C-x g") 'magit-status)

(define-key global-map (kbd "\C-w") 'backward-kill-word)

(define-key global-map (kbd "\C-s") 'isearch-forward-regexp)
(define-key global-map (kbd "\C-r") 'isearch-backward-regexp)
(provide 'keybindings)
