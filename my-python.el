(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                           (file-name-directory buffer-file-name))))
  (list "pyflakes" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)

(setq python-shell-interpreter "ipython")

(defun python-run-buffer ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat "python " (buffer-name)))
)
(setq compilation-scroll-output t)

(add-hook 'python-mode-hook '(lambda ()
                               (local-set-key "\C-c\C-c" 'python-run-buffer)
                               ))

(provide 'my-python)
