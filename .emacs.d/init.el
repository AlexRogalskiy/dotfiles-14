(package-initialize)

(setq gc-cons-threshold 50000000)

(add-hook 'emacs-startup-hook 'my/set-gc-threshold)
(defun my/set-gc-threshold ()
  "Reset `gc-cons-threshold' to its default value."
  (setq gc-cons-threshold 800000))

(setq-default custom-file (expand-file-name ".custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(load-file "./.emacs.d/packages.el")
(load-file "./.emacs.d/functions.el")
(load-file "./.emacs.d/globals.el")
(load-file "./.emacs.d/hooks.el")
(load-file "./.emacs.d/keybindings.el")
(load-file "./.emacs.d/yas.el")
(load-file "./.emacs.d/theme.el")
(load-file "./.emacs.d/modeline.el")
(load-file "./.emacs.d/neotree.el")