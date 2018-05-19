(add-hook 'prog-mode-hook (lambda()
			    (rainbow-delimiters-mode 1)
			    (show-paren-mode 1)
			    (auto-fill-mode)
			    )
	  )

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'focus-out-hook #'garbage-collect)

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

(require 'vc)
(cl-defun eyebrowse-magic-switch()
  (ignore-errors
    (let ((buf (vc-git-root
		(buffer-file-name
		 (window-buffer
		  (selected-window))))))
      (message "buf: %s" buf)
      (neo-buffer--change-root
       buf)
      (return-from eyebrowse-magic-switch)
      
      )
    )

  (ignore-errors
    (message "dir: %s" default-directory)
    (neo-buffer--change-root default-directory)
    )
  )
  
(add-hook 'eyebrowse-post-window-switch-hook (eyebrowse-magic-switch))

(provide 'hooks)
