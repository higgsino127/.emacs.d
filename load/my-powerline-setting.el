

;;; 前に行番号、総行数、桁番号を表示
;;; 総行数の計する%記法がないので遅延で計算させる
;; thx rubikitch
(defvar-local mode-line-last-line-number 0)
(defvar-local clnaw-last-tick 0)
(defun calculate-total-line-numbers ()
 "Calculate total line numbers."
 (unless (eq clnaw-last-tick (buffer-modified-tick))
   (setq mode-line-last-line-number (line-number-at-pos (point-max)))
   (setq clnaw-last-tick (buffer-modified-tick))
   (force-mode-line-update)))
(run-with-idle-timer 2 t 'calculate-total-line-numbers)

;; 現在行、総行、文字位置、選択範囲の文字数など
;; (setq mode-line-position
;;       '(:eval (format "%d/%d %d/%d %s"
;;                       (line-number-at-pos)
;;                       mode-line-last-line-number
;;                       (point)
;;                       (point-max)
;;                       (if mark-active
;;                           (concat "["
;;                                   (format "%s" (count-lines (region-end) (region-beginning)))
;;                                   "-"
;;                                  (format "%s" (- (region-end) (region-beginning)))
;;                                  "]")
;;                         ""))
;;               ))

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
                                (powerline-raw (char-to-string #xe0b1) mode-line 'l) ;; separator
                                ;; line number 
                                (powerline-raw " "  mode-line )
                                (powerline-raw "L:%l" mode-line 'l)
                                (powerline-raw " "  mode-line)
                                
                                ;; (powerline-raw " " mode-line)
                                (powerline-raw (char-to-string #xe0b0) mode-line-sep) ;; separator 
                                
                                ;; save or modifined or read-only
                                (powerline-raw (if (eql buffer-read-only t) (char-to-string #xe0a2) (char-to-string #xf09c) ) face1 'l)
                                (powerline-raw "%b" face1 'l)
                                (powerline-raw " " face1)
                                (powerline-raw (char-to-string #xe0b1) face1 'r) ;; separator
                                ;;(funcall separator-left face1 face2)
                                (powerline-raw (if (buffer-modified-p) (char-to-string #xf00d) (char-to-string #xf00c) ) face1 'l)
                                (powerline-raw (if (buffer-modified-p) "Modified" "Saved") face1 'l)
                                (powerline-raw " " face1)
                                
                                (powerline-raw (char-to-string #xe0b1) face1 'r) ;; separator
                                (powerline-raw (char-to-string #xe0a0) face1 'r) ;; branch symbol 
                                (powerline-raw (if ( string-match "^refs/heads/" (replace-regexp-in-string "[\r\n]+\\'" "" (shell-command-to-string "git symbolic-ref -q HEAD")) )
                                                   (format "%s" (substring (replace-regexp-in-string "[\r\n]+\\'" "" (shell-command-to-string "git symbolic-ref -q HEAD")) 11)) "None")
                                               face1)
                                (powerline-raw (char-to-string #xe0b1) face1 'r)
                                )) ;; lefter side end 
                          (rhs (list
                                (powerline-raw (char-to-string #xe0b3) face2 'l)
                                (powerline-raw " " face2)
                                (powerline-raw (char-to-string #xf43a) face2 'l)
                                (powerline-raw (format-time-string "%H:%M") face2 'l )
                                (powerline-raw (char-to-string #xe0b3) face2 'l)
                                (powerline-raw " " face2)
                                (powerline-raw (replace-regexp-in-string "^.*/\\(.*\\)/" "\\1/" default-directory) face2)
                                (powerline-raw global-mode-string face2 'l)
                                (powerline-raw (char-to-string #xe0b2) face2 'l)
                                
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


