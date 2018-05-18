(add-hook 'prog-mode-hook (lambda()
			    (rainbow-delimiters-mode 1)
			    (show-paren-mode 1)
			    )
	  )

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(add-hook 'web-mode-hook (lambda ()
			   (setq web-mode-markup-indent-offset 2)
			   (setq web-mode-attr-indent-offset 2)
			   (setq web-mode-css-indent-offset 2)
			   (setq web-mode-code-indent-offset 2)
			   (setq css-indent-offset 2)
			   (rainbow-mode 1)
			   (set-face-background 'web-mode-current-element-highlight-face "khaki1")
			   )
	  )


(add-hook 'rjsx-mode-hook (lambda ()
			    (emmet-mode 1)
			    (smartparens-mode 1)
			    (auto-complete-mode 1)
			    (add-to-list 'ac-sources 'ac-source-filename)
			    )
	  )

(add-hook 'python-mode-hook (lambda()
			      (anaconda-mode 1)
			      )
	  )

(add-hook 'lua-mode-hook (lambda()
			   (setq lua-indent-level 2)
			   )
	  )
