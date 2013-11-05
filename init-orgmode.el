(setq org-startup-indented 1)

(setq org-directory "~/Dropbox/Todo")

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/Todo/mobile.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(setq org-default-notes-file (concat org-directory "/refile.org"))
(define-key global-map "\C-cc" 'org-capture)

(define-key global-map "\C-ca" 'org-agenda)

(setq org-agenda-files (list
             (concat org-directory "/Pixelmedia.org")
             (concat org-directory "/Personal.org")
             (concat org-directory "/refile.org")
             (concat org-directory "/Notes.org")
             (concat org-directory "/GravityTracks.org")))


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-use-fast-todo-selection t)

;; Capture templates
(setq org-capture-templates
      (quote (("t" "todo" entry (file+headline (concat org-directory "/refile.org") "Tasks")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("n" "note" entry (file (concat org-directory "/Notes.org"))
               "* %? :NOTE:\n%U\n%a\n")
              ("m" "Meeting" entry (file+headline (concat org-directory "/refile.org") "Meetings")
               "* MEETING with %?\n%U" :clock-in t :clock-resume t)
              ("s" "Schedule" entry (file+headline (concat org-directory "/refile.org") "Schedule")
               "* TODO %?\nSCHEDULED: %^{When}t")
              ("p" "Phone call" entry (file+headline (concat org-directory "/refile.org"), "Phone")
               "* PHONE %?\n%U" :clock-in t :clock-resume t))))

;; Refile
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 9))))
(setq org-refile-use-outline-path t)
(setq org-completion-use-ido t)

;; Time Tracking
(org-clock-persistence-insinuate)
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
(setq org-clock-persist t)
(setq org-clock-out-when-done t)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-clock-into-drawer t)

;; Attachments
(setq org-id-method (quote uuidgen))
(setq org-file-apps '((".*" . default)))

;; logging
(setq org-log-done (quote time))
(setq org-log-into-drawer t)
(setq org-log-state-notes-insert-after-drawers nil)

(setq org-src-fontify-natively t)
(setq org-agenda-window-setup 'current-window)

(require 'org-protocol)

(provide 'init-orgmode)
