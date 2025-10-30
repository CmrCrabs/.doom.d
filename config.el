;; sync N

;; misc 
(setq user-full-name "Zayaan Azam"
      user-mail-address "zf.azam@proton.me")

(setq display-line-numbers-type 'relative)

(blink-cursor-mode 1)
(setq which-key-idle-delay 0.0)
(setq-default tab-width 2)

;; binds
(map! :after evil
      :n "H" 'centaur-tabs-backward
      :n "L" 'centaur-tabs-forward)
(map! 
 :leader "f o" (lambda () (interactive) (affe-find "~/org/"))
 :leader "f /" 'affe-grep
 :leader "[ [" 'org-roam-node-insert
 :leader "d" 'org-roam-dailies-goto-today)

;; TODO mouse support
(unless (display-graphic-p)
  (xterm-mouse-mode 1))

;; elisp
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)

;; org
(after! org
  (setq org-directory "~/org")
  (setq org-log-done 'time)
  (setq org-log-into-drawer "LOGBOOK")
  (setq org-deadline-warning-days 0)

  ;;(setq org-agenda-start-with-log-mode '(closed))
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done  t)
  (setq org-agenda-block-seperator 8411)
  (setq org-agenda-current-time-string "⭠  now ")
  (setq org-agenda-span 'week)

  (setq org-agenda-use-time-grid t)
  
  (setq org-agenda-files
        (append
         (doom-files-in "~/org/projects/" :match "\\.org$")
         (doom-files-in "~/org/time/" :match "\\.org$")
         (doom-files-in "~/org/emplace/" :match "\\.org$")
         (doom-files-in "~/org/academic/university/" :match "\\.org$")
         (doom-files-in "~/org/journal/"  :match "\\.org$")))

  (setq org-agenda-custom-commands
        '(
          ("o"
           "short term"
           ((agenda "" ((org-agenda-span 3)
                        (org-agenda-start-day "-1d")
                        (org-agenda-start-on-weekday nil)))))

          ("w"
           "weekdays"
           ((agenda "" ((org-agenda-span 5)
                        (org-agenda-start-on-weekday 1)
                        (org-agenda-start-day
                         (if (member (calendar-day-of-week (calendar-current-date)) '(0 6))
                             "+0w" "0"))))))
          ))

  (setq org-agenda-breadcrumbs-level 2)
  (setq org-agenda-prefix-format
        '((agenda . "%i %-12:c%?-12t% s%b")
          (todo . " %b %i %-12:c")
          (tags . " %i %-12:c")
          (search . " %i %-12:c"))
        )

  (setq org-todo-keywords
        '((sequence "TODO(t)" "INPR(i!)" "|" "DONE(d!)")
          (sequence "PROJ(l)" "MKNG(k!)" "|" "MADE(m@/!)")
          (sequence "GOAL(g)" "INPR(i!)" "|" "CMPL(cm@/!)")
          (sequence "HABT(H)" "|" "DONE(d!)")
          (sequence "LECT(l)" "TTRL(t)" "ATND(a!)" "|" "CCLD(c!)")
          (sequence "HWRK(h)" "INPR(i!)" "|" "SUBM(s!)"))))

;; org-roam
(setq org-roam-directory "~/org")
(setq org-roam-dailies-directory "journal/")
(setq org-roam-file-extensions '("org" "md"))

(setq md-roam-file-extension "md")

(md-roam-mode 1)
(org-roam-db-autosync-mode)

;;org-roam templates
(defun my/org-roam-anki-template ()
  (let ((tag (read-string "tag: "))
        (title (read-string "title: ")))
    ("f" "flashcard"
     plain
     "
#+title: %(identity title)
#+filetags: :flashcard:%(identity tag):

* ${title}
:PROPERTIES:
:ANKI_NOTE_TYPE: Basic
:ANKI_DECK: ,(replace-regexp-in-string \"/\" \"::\" (identity tag))
:END:
** Front
%?
** Back
"
     :target (file+head
              ,(expand-file-name
                (concat (replace-regexp-in-string "[^a-zA-Z0-9]+" "_" (identity title)) ".org")
                "~/org/academic/flashcards/")
              )
     :unarrowed t)))

(setq org-roam-capture-templates 
      '(("d" "default" plain "%?"
         :target (file+head "${slug}.org"
                            "#+title: ${title}\n#+filetags: :daily:")
         :unnarrowed t))
      ;;'(my/org-roam-anki-template)
      )

;; org roam daily note
(setq org-roam-dailies-capture-templates
      '(("d" "default" plain
         (file "~/org/templates/daily_note.org")
         :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>")
         :unnarrowed t)))


;; theme
(setq doom-font (font-spec :family "Iosevka-Icarus" :size 14)
      doom-variable-pitch-font (font-spec :family "Iosevka-Icarus" :size 14)
      doom-unicode-font (font-spec :family "Iosevka-Icarus")
      doom-big-font (font-spec :family "Iosevka-Icarus" :size 22))

(setq doom-theme 'kanagawa-dragon)
(after! doom-themes
  (unless (display-graphic-p)
    (set-face-background 'default "undefined")))


;; dashboard
(defun banner-of-doom ()
(let* ((banner '("                 _..--+~/@-~--.                         "
                 "             _-=~      (  .   \"}                       "
                 "          _-~     _.--=.\\ \\\"\"\"                     "
                 "        _~      _-       \\ \\_\\                       "
                 "       =      _=          '--'                          "
                 "      '      =                             .            "
                 "     :      :       ____                   '=_. ___     "
                 "___  |      ;                            ____ '~--.~.   "
                 "     ;      ;                               _____  } |  "
                 "  ___=       \\ ___ __     __..-...__           ___/__/_"
                 "     :        =_     _.-~~          ~~--.__             "
                 "_____ \\         ~-+-~                   ___~=_______   "
                 "     ~@#~~ == ...______ __ ___ _--~~--_                 "
                 "                                                        "
                 "                      e m a c s                        "))
       (longest-line (apply #'max (mapcar #'length banner))))
  (put-text-property
   (point)
   (dolist (line banner (point))
     (insert (+doom-dashboard--center
              +doom-dashboard--width
              (concat line (make-string (max 0 (- longest-line (length line))) 32)))
             "\n"))
   'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'banner-of-doom)

(assoc-delete-all "Recently opened files" +doom-dashboard-menu-sections)
(assoc-delete-all "Open project" +doom-dashboard-menu-sections)
(assoc-delete-all "Open org-agenda" +doom-dashboard-menu-sections)
(assoc-delete-all "Open private configuration" +doom-dashboard-menu-sections)
(assoc-delete-all "Jump to bookmark" +doom-dashboard-menu-sections)
(assoc-delete-all "Reload last session" +doom-dashboard-menu-sections)
(assoc-delete-all "Open documentation" +doom-dashboard-menu-sections)

(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Nah, I'd win.")))




;; VISUAL CALENDAR BLOCKING https://www.reddit.com/r/orgmode/comments/114n580/how_to_show_orgagenda_activities_covering_their/
;; CUSTM MAKE CODE BETTER
;; ALSO WRITE CODE TO FULLY STOCK AGENAS
  ;;(defun my:org-agenda-time-grid-spacing ()
  ;;  "Set different line spacing w.r.t. time duration."
  ;;  (save-excursion
  ;;  (let ((colors (list "DarkGoldenrod2" "DarkSlateGray2" "OliveDrab3" "indian red" "SkyBlue3" "NavajoWhite2" "SteelBlue4"))
  ;;      pos
  ;;      duration)
  ;;    (nconc colors colors)
  ;;    (goto-char (point-min))
  ;;    (while (setq pos (next-single-property-change (point) 'duration))
  ;;    (goto-char pos)
  ;;    (when (and (not (equal pos (point-at-eol)))
  ;;           (setq duration (org-get-at-bol 'duration)))
  ;;      (let ((line-height (if (< duration 15) 1.0 (+ 0.5 (/ duration 30))))
  ;;        (ov (make-overlay (point-at-bol) (1+ (point-at-eol)))))
  ;;      (overlay-put ov 'face `(:background ,(car colors) :foreground "gray10"))
  ;;      (setq colors (cdr colors))
  ;;      (overlay-put ov 'line-height line-height)
  ;;      (overlay-put ov 'line-spacing (1- line-height))))))))

;; AI slop org todo logging copy to daily note 
;;(defun my/org-roam-log-todo-state-change ()
;;  (when (and (string= major-mode "org-mode")
;;             (boundp 'org-state)
;;             org-state)
;;    (let* ((log-heading "Task Log") ;; <-- customize this heading name
;;           (time (format-time-string "[%H:%M]"))
;;           (log-entry (format "- %s %s → %s :: %s\n"
;;                              time org-last-state org-state (org-get-heading t t t t))))
;;      ;; Open today's daily note and insert the log entry under the heading
;;      (org-roam-dailies-capture-today
;;       nil
;;       (list "t" ;; capture key (arbitrary — doesn’t need to be in your templates)
;;             `("TODO log" entry
;;               (file+headline "" ,log-heading)
;;               ,log-entry
;;               :immediate-finish t
;;               :empty-lines-after 1))))))
;;
;;(add-hook 'org-after-todo-state-change-hook #'my/org-roam-log-todo-state-change)
