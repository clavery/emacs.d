
;; fix path on os x
(exec-path-from-shell-initialize)

;; let command be meta too
(setq mac-command-modifier 'meta)

(add-to-list 'face-font-family-alternatives
             '("Monaco"))

(setq initial-frame-alist '((font . "Monaco-14")))
(setq default-frame-alist '((font . "Monaco-14")))

(provide 'init-osx)
