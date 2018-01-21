(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("2e2ecba9a216bc734276a0642def5fccec44ee1facb4b6562a74e7fdcd5db997" "628cc301749fc392d32c26ba913402967a17d9f44c0a2b5e4c77850b50b5588b" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "b447129c5efd45c7dcfaaf99b94caf479637ff205b4e5b566efc7ce5496272ab" "df258df60e7e87aa3f3b0ba727f54d6c968036e23ac60673b8375525e5ea9c28" "2f9216992371bcc9bc26bca11698d9c778ef4609ad94f86e4810607bf0fde82e" "355e1c0eb7cd20794e983b4c6f5c0c978a85b159d6aadb2fae15faa25fb344e5" "4137af91ea70f2b3ba0f5dee69899f2c81be463c54d931179d2e5038c4947d36" "2affeafce8e8bf5803ccce901f779f95d0b0ac122145efee753baa4af4d73e26" "873d8b58357aecbeedd0acdda2aca3f3f5b92ceb4a5dbe9384a4837fe1e34aa3" default)))
 '(package-selected-packages
   (quote
    (highlight-parentheses rainbow-delimiters anaconda-mode solarized-theme react-snippets yasnippet ac-anaconda emmet-mode smartparens ag gotham-theme helm projectile neotree markdown-mode magit flycheck auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'cl)
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(defvar alsw/mypackages '(
			  ag
			  anaconda-mode
			  auto-complete
			  autothemer
			  bind-key
			  emmet-mode
			  flycheck
			  gotham-theme
			  helm
			  helm-projectile
			  js2-mode
			  json-mode
			  magit
			  markdown-mode
			  neotree
			  popup
			  popwin
			  projectile
			  rainbow-delimiters
			  rainbow-mode
			  react-snippets
			  rjsx-mode
			  wakatime-mode
			  web-mode
			  which-key
			  yasnippet
			  ))

(defun alsw/packages-installed-p ()
  (loop for pkg in alsw/mypackages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (alsw/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg alsw/mypackages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(require 'server)
(unless (server-running-p)
  (server-start))

(setq
 initial-scratch-message ""
 inhibit-startup-message t
 make-backup-files nil
 auto-save-default nil
 indent-tabs-mode nil
 inhibit-splash-screen t
 tab-width 2
 version-control t
 coding-system-for-read 'utf-8
 coding-system-for-write 'utf-8
 default-fill-column 80
 js2-basic-offset 2
 )

(delete-selection-mode t)
(blink-cursor-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-linum-mode 1)
(setq linum-format "%4d \u2502 ")
(setq column-number-mode t)

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(setq ac-disable-faces nil)


(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq-default neo-smart-open t)
(setq-default neo-dont-be-alone t)
(add-hook 'neo-change-root-hook
          (lambda () (neo-buffer--with-resizable-window
		      (let ((fit-window-to-buffer-horizontally t))
			(fit-window-to-buffer)))))

(global-flycheck-mode)
(global-wakatime-mode)

(require 'helm)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)
(helm-mode 1)

(require 'popwin)
(popwin-mode 1)

(which-key-mode 1)

(require 'emmet-mode)
(require 'web-mode)
(setq js2-basic-offset 2)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-block-face t)
(setq web-mode-enable-part-face t)
(setq web-mode-enable-current-element-highlight t)

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))

(require 'yasnippet)
(yas-global-mode 1)

(defun common-hook ()
  "Common for all modes."
  (rainbow-delimiters-mode 1)
  (show-paren-mode 1)
  )

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (common-hook)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq css-indent-offset 2)
  (rainbow-mode 1)
  (set-face-background 'web-mode-current-element-highlight-face "khaki1")
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

(require 'kaolin-themes)

(load-theme 'kaolin-ocean)

(require 'react-snippets)

(defun my-rjsx-mode-hook ()
  "Hook for RJSX mode (React)."
  (common-hook)
  (emmet-mode 1)
  (smartparens-mode 1)
  (setq js2-basic-offset 2)
  (auto-complete-mode 1)
  (add-to-list 'ac-sources 'ac-source-filename)
  )

(add-hook 'rjsx-mode-hook 'my-rjsx-mode-hook)

(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

(defun my-python-mode-hook ()
  "Hook for python mode."
  (common-hook)
  (anaconda-mode 1)
  )

(when (window-system)
  (set-frame-font "Terminus"))

(custom-set-variables '(wakatime-api-key ""))