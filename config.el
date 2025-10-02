;; sync N

(setq user-full-name "Zayaan Azam"
      user-mail-address "zf.azam@proton.me")

(setq display-line-numbers-type 'relative)
(setq org-directory "~/org")

(blink-cursor-mode 1)
(setq which-key-idle-delay 0.0)

(unless (display-graphic-p)
  (xterm-mouse-mode 1))

(define-key evil-normal-state-map (kbd "H") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "L") 'centaur-tabs-backward)

(after! evil
  (evil-define-key 'normal 'global (kbd "SPC f f") 'affe-find)
  (evil-define-key 'normal 'global (kbd "SPC f /") 'affe-grep)
        )

;; TODO mouse support


(setq doom-theme 'kanagawa-dragon)
(after! doom-themes
  (unless (display-graphic-p)
    (set-face-background 'default "undefined")))

(after! doom-modeline
  (setq doom-modeline-segment-emacs-state '(emacs-state))
  (setq doom-modeline-modal-icon nil))  ;; no icon, just text

;; dash splash
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

;;(assoc-delete-all "Open project" +doom-dashboard-menu-sections)
(assoc-delete-all "Open private configuration" +doom-dashboard-menu-sections)
(assoc-delete-all "Jump to bookmark" +doom-dashboard-menu-sections)
(assoc-delete-all "Reload last session" +doom-dashboard-menu-sections)
(assoc-delete-all "Recently opened files" +doom-dashboard-menu-sections)
(assoc-delete-all "Open documentation" +doom-dashboard-menu-sections)

;;(add-to-list '+doom-dashboard-menu-sections
;;'("Fuzzy Grep"
;;   :icon (all-the-icons-octicon "calendar" :face 'doom-dashboard-menu-title)
;;   :face (:inherit (doom-dashboard-menu-title bold))
;;   :action affe-grep))


(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Nah, I'd win.")))

