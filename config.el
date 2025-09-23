;; sync N

(setq user-full-name "Zayaan Azam"
      user-mail-address "zf.azam@proton.me")

(setq display-line-numbers-type 'relative)
(setq org-directory "~/pkms/")

(blink-cursor-mode 1)
(setq which-key-idle-delay 0.0)


(setq doom-theme 'kanagawa-dragon)
(after! doom-themes
  (unless (display-graphic-p)
    (set-face-background 'default "undefined")))

(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-lsp-icon t)
(setq doom-modeline-major-mode-color-icon t)



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

(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Nah, I'd win.")))



;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
