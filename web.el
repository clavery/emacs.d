
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))


(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


(add-to-list 'auto-mode-alist '("/\\(templates\\)/.*\\.html\\'" . web-mode))

(setq web-mode-engines-alist
      '(("jinja2"    . "/\\(templates\\)/.*\\.html\\'"))
)

(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
(defun flymake-xml-init ()
  (list "xmllint" (list "--valid" (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))))
(provide 'web)
