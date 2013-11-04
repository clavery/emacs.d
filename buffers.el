
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("org" (mode . org-mode))
               ("dirs" (mode . dired-mode))
               ("python" (mode . python-mode))
               ("php" (mode . php-mode))
               ("js" (mode . js2-mode))
               ("templates" (mode . web-mode))
               ("emacs" (or
                         (name . "^.+\\.el$")
                         (name . "^\\*.+\\*$")))))))

(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

(defun ibuffer-vc-add-vc-filter-groups ()
      (interactive)
      (dolist (group (ibuffer-vc-generate-filter-groups-by-vc-root))
        (add-to-list 'ibuffer-filter-groups group t)))
 
(add-hook 'ibuffer-hook
          (lambda ()
            ;; (ibuffer-vc-set-filter-groups-by-vc-root)
            (ibuffer-switch-to-saved-filter-groups "default")
            (ibuffer-vc-add-vc-filter-groups)))

(eval-after-load 'ibuffer
  '(progn

     (require 'ibuffer-vc)

     ;; Use human readable Size column instead of original one
     (define-ibuffer-column size-h
       (:name "Size" :inline t)
       (cond
        ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
        ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
        (t (format "%8d" (buffer-size)))))

     ))

(setq ibuffer-filter-group-name-face 'font-lock-doc-face)

(define-key ibuffer-mode-map (kbd "C-c g") 'ibuffer-vc-set-filter-groups-by-vc-root)
(define-key ibuffer-mode-map (kbd "C-c C-g") 'ibuffer-vc-set-filter-groups-by-vc-root)


(provide 'buffers)
