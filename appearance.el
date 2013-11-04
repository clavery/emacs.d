
(setq font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

(global-hl-line-mode -1)

(setq custom-theme-directory (concat user-emacs-directory "themes"))

(load-theme 'molokai t)
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; relative line numbers
(defvar my-linum-format-string "%3d")

(add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)

(defun my-linum-get-format-string ()
  (let* ((width (1+ (length (number-to-string
                             (count-lines (point-min) (point-max))))))
         (format (concat "%" (number-to-string width) "d ")))
    (setq my-linum-format-string format)))

(defvar my-linum-current-line-number 0)

(setq linum-format 'my-linum-relative-line-numbers)

(defun my-linum-relative-line-numbers (line-number)
  (propertize (format my-linum-format-string line-number) 'face
              (if (= line-number my-linum-current-line-number)
                  'font-lock-string-face
                  'linum)))

(defadvice linum-update (around my-linum-update)
  (let ((my-linum-current-line-number (line-number-at-pos)))
    ad-do-it))
(ad-activate 'linum-update)


(add-to-list 'face-font-family-alternatives
             '("Consolas"))

(setq initial-frame-alist '(
                            (font . "Consolas-14")
                            ))
(setq default-frame-alist '(
                            (font . "Consolas-14")
                            ))
(add-to-list 'default-frame-alist '(cursor-color . "#FFFF00"))
(set-cursor-color "#FFFF00")



(provide 'appearance)
