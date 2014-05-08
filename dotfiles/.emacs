(electric-indent-mode 1)
(setq org-todo-keywords
             '((sequence "TODO" "IN PROGRESS" "DONE" )))
(setq org-todo-faces
      (quote (("IN PROGRESS" :foreground "yellow"))))
(custom-set-variables
 '(inhibit-startup-screen t) ; doesn't load introductory screen
)

(tool-bar-mode -1) ; no toolbar
(setq mac-command-modifier 'control)
