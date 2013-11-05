;; "ibuffer" specific configuration

;; default grouping of ibuffer
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

;; don't ask to kill buffers
(setq ibuffer-expert t)

;; don't show empty groups
(setq ibuffer-show-empty-filter-groups nil)

;; loads version control groups (call on entering ibuffer)
(defun ibuffer-vc-add-vc-filter-groups ()
  (interactive)
  (dolist (group (ibuffer-vc-generate-filter-groups-by-vc-root))
    (add-to-list 'ibuffer-filter-groups group t)))

(add-hook 'ibuffer-hook
          (lambda ()
            ;; uncomment to use VC groups by default instead
            ;; (ibuffer-vc-set-filter-groups-by-vc-root)
            (ibuffer-switch-to-saved-filter-groups "default")
            (ibuffer-vc-add-vc-filter-groups)))

(eval-after-load 'ibuffer
  '(progn
     ;; Use human readable Size column instead of original one
     (define-ibuffer-column size-h
       (:name "Size" :inline t)
       (cond
        ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
        ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
        (t (format "%8d" (buffer-size)))))

     (setq ibuffer-formats '((mark modified read-only " "
                                   (name 18 18 :left :elide)
                                   " "
                                   (size-h 9 -1 :right)
                                   " "
                                   (mode 16 16 :left :elide)
                                   " " filename-and-process)
                             (mark modified read-only vc-status-mini " "
                                   (name 18 18 :left :elide)
                                   " "
                                   (size-h 9 -1 :right)
                                   " "
                                   (mode 16 16 :left :elide)
                                   " "
                                   (vc-status 16 16 :left)
                                   " "
                                   filename-and-process)))

     ;; C-c C-g (or g) to group by version control dir (ie. projects)
     (define-key ibuffer-mode-map (kbd "C-c g") 'ibuffer-vc-set-filter-groups-by-vc-root)
     (define-key ibuffer-mode-map (kbd "C-c C-g") 'ibuffer-vc-set-filter-groups-by-vc-root)

     ))


(setq ibuffer-filter-group-name-face 'font-lock-doc-face)

(provide 'init-ibuffer)
