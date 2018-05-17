;; Mode line settings
(set-face-attribute 'mode-line nil
		    :background "#333353"
		    :box '(:line-width 8 :color "#333353")
		    )

(set-face-attribute 'mode-line-inactive nil
		    :foreground "#666699"
		    :box '(:line-width 8 :color "#333353")
		    )

(defface mode-line-buffer-name
  '((t
     :foreground "#f1eff8"
     :background "#333353"
     :box(:line-width 8 :color "#333353")
     :family "Terminus"
     :height 130
     ))
  "Buffer name face"
  :group 'basic-faces
  )

(defface mode-line-dir-name
  '((t
     :foreground "#7aa5ff"
     :background "#333353"
     :box(:line-width 8 :color "#333353")
     :family "Terminus"
     :height 130
     ))
  "Directory name in mode line"
  :group 'basic-faces
  )

(defface mode-line-accent
  '((t
     :foreground "#f1eff8"
     :background "#666699"
     :box(:line-width 8 :color "#ff79c6")
     ))
  "Accented parts of mode line"
  :group 'basic-faces
  )

(setq-default mode-line-format
	      '(
		(:eval
		 (when (eql buffer-read-only t)
		   (propertize
		    (format "   %s   " (all-the-icons-octicon "lock" :v-adjust -0.05))
		    'face `(
			    :foreground "#f1eff8"
			    :background "#666699"
			    :box(:line-width 8 :color "#666699")
			    :family ,(all-the-icons-octicon-family)
			    )
		    )
		   )
		 )

		(:eval
		 (if (string-match "\<.*\>" (buffer-name))
		     (concat
		      (propertize (format " %s/" (substring (eval(match-string 0)) 2 ))
				  'face 'mode-line-dir-name
				  )
		      (propertize (format "%s " (substring (buffer-name) 0 (match-beginning 0))) 'face 'mode-line-buffer-name)
		      )

		   (propertize "%b " 'face 'mode-line-buffer-name)
		   )
		 )
		
		;; (:eval
		;;  (if (buffer-file-name)
		;;      (propertize
		;;       (concat
		;;        " "
		;;        (all-the-icons-faicon "file-o" :v-adjust -0.05)
		;;        " "
		;;        (eval(when (string-match "<.*>$" buffer-name)
		;; 	 (replace-regexp-in-string ">" "/" (nth 1 (split-string (buffer-name) "<")))
		;; 	 ))
		;;        (car (split-string (buffer-name) "<"))
		;;        " "
		;;        )
		;;       'face 'mode-line-dir-name
		;;       )
		;;    (propertize " %b "
		;; 	       'face 'mode-line-dir-name
		;; 	       )
		;;    )
		;;  )

		(:eval
		 (if (buffer-modified-p)
		     (propertize (format " %s " (all-the-icons-faicon "floppy-o" :v-adjust -0.05))
				 'face '(:background "#666699" :foreground "#f1eff8" :box(:line-width 8 :color "#666699"))
				 )
		   nil
		     )
		   )

		(:propertize " %m ")
		" "
		(:propertize " %l:%c " face (:foreground "#f1eff8" :weight light))

		(:eval (when (stringp vc-mode)
			 (propertize (format "%s %s" (all-the-icons-octicon "git-branch" :v-adjust -0.05) (replace-regexp-in-string "^ Git-" "" (eval vc-mode))))
			 )
		       )
		" "
		(:propertize (global-mode-string global-mode-string) face (:foreground "#f1eff8" :weight normal))
		)
	      )