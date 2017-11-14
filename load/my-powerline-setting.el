


;;font utf-8 value from https://github.com/ryanoasis/nerd-fonts
(defun powerline-default-theme-mod ()
  "Setup the default mode-line."
  (interactive)
  (setq powerline-current-separator 'utf-8)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (mode-line-sep (if active 'mode-line-sep 'mode-line-inactive-sep))
                          ;; (face1 (if active 'powerline-active1 'powerline-inactive1))
                          ;; (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (face1     (if active 'powerline-active1     'powerline-active1))
                          (face1-sep (if active 'powerline-active1-sep 'powerline-active1-sep))
                          (face2     (if active 'powerline-active2     'powerline-active2))
                          (face2-sep (if active 'powerline-active2-sep 'powerline-active2-sep))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))

                          (separator-right (intern (format "powerline-%s-%s"
                                                           (powerline-current-separator)
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list
                                (powerline-raw (char-to-string #xf097) mode-line 'l)
                                (when powerline-display-buffer-size
                                  (powerline-buffer-size mode-line 'l))
                                (powerline-raw (char-to-string #xe0b1) mode-line 'l)
                                
                                ;; (powerline-raw "L" mode-line 'l)
                                ;; ;;(powerline-raw (char-to-string #xe0a1) mode-line 'r)
                                ;; (powerline-raw "%l" mode-line 'l)
                                ;;(powerline-raw "/"  mode-line )
                                (powerline-raw " "  mode-line )
                                (powerline-raw "%p" mode-line 'r)
                                
                                (powerline-raw " " mode-line)
                                ;;(funcall separator-left mode-line-sep face1)
                                (powerline-raw (char-to-string #xe0b0) mode-line-sep)
                                ;;(funcall separator-left mode-line face1)
                                ;;(when (eql buffer-read-only t) (powerline-raw (char-to-string #xe0a2) face1 'l) )
                                (powerline-raw (if (eql buffer-read-only t) (char-to-string #xe0a2) (char-to-string #xf09c) ) face1 'l)
                                (powerline-raw "%b" face1 'l)
                                (powerline-raw " " face1)
                                (powerline-raw (char-to-string #xe0b1) face1 'r)
                                ;;(funcall separator-left face1 face2)
                                (powerline-raw (if (buffer-modified-p) (char-to-string #xf00d) (char-to-string #xf00c) ) face1 'l)
                                (powerline-raw (if (buffer-modified-p) "Modified" "Saved") face1 'l)
                                (powerline-raw " " face1)
                                
                                (powerline-raw (char-to-string #xe0b1) face1 'r)
                                (powerline-raw (char-to-string #xe0a0) face1 'r)
                                (powerline-raw (if ( string-match "^refs/heads/" (replace-regexp-in-string "[\r\n]+\\'" "" (shell-command-to-string "git symbolic-ref -q HEAD")) )
                                                   (format "%s" (substring (replace-regexp-in-string "[\r\n]+\\'" "" (shell-command-to-string "git symbolic-ref -q HEAD")) 11)) "None")
                                               face1)
                                ;;(vc-working-revision (buffer-file-name (current-buffer)) face1)
                                ;;(powerline-raw " " face1)
                                (powerline-raw (char-to-string #xe0b1) face1 'r)
                                
                                ;;(powerline-raw (char-to-string #xe0b0) face2-sep 'r)
                                
                                
                                ))
                          (rhs (list
                                (powerline-raw (char-to-string #xe0b3) face2 'l)
                                (powerline-raw " " face2)
                                (powerline-raw (char-to-string #xf43a) face2 'l)
                                (powerline-raw (format-time-string "%H:%M") face2 'l )
                                (powerline-raw (char-to-string #xe0b3) face2 'l)
                                (powerline-raw " " face2)
                                (powerline-raw (replace-regexp-in-string "^.*/\\(.*\\)/" "\\1/" default-directory) face2)
                                ;;(powerline-raw " " face2)
                                (powerline-raw global-mode-string face2 'l)
                                ;;(funcall separator-right mode-line-sep face2)
                                (powerline-raw (char-to-string #xe0b2) face2 'l)
                                ;;(powerline-raw (char-to-string #xe0c7) face2 'l)
                                ;;(powerline-buffer-id nil 'l)
                                
                                (powerline-raw " " mode-line)
                                (powerline-raw (char-to-string #xf011) mode-line 'l)
                                (when (boundp 'erc-modified-channels-object)
                                  (powerline-raw erc-modified-channels-object mode-line 'l))
                                (powerline-major-mode mode-line 'l)
                                (powerline-process mode-line)
                                (powerline-minor-modes mode-line 'l)
                                (powerline-narrow mode-line 'l)

                                (when (and (boundp 'which-func-mode) which-func-mode)
                                  (powerline-raw which-func-format nil 'l))
                                (powerline-raw (char-to-string #xe0b3) mode-line 'l)
                                (when powerline-display-mule-info (powerline-raw mode-line-mule-info nil 'l))
                                )
                               ))
                     (concat (powerline-render lhs)
                             (powerline-fill face2 (powerline-width rhs))
                             (powerline-render rhs))
                     )))))


