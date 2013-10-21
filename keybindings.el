(define-key global-map (kbd "RET") 'newline-and-indent)
(define-key global-map (kbd "\C-z") 'evil-emacs-state)

(define-key global-map (kbd "\C-x k") 'kill-this-buffer)

(define-key global-map (kbd "\C-x g") 'magit-status)
(provide 'keybindings)
