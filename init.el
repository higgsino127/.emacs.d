
;;; uncomment this line to disable loading of "default.el" at startup
(setq inhibit-default-init t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
;; japanse environment
;;(set-language-environment "japanese")

;; Don't view start-up page
(setq inhibit-startup-message t)

;; Hide meanu bar
(menu-bar-mode -1)

;; tab ---->> spacex4
(setq-default tab-width 4 indent-tabs-mode nil)

;; change tab behav
(setq indent-line-function 'indent-to-left-margin)

;; rm autofile at exit emacs 
(setq delete-auto-save-files t)

;; don't make *~ file
(setq make-backup-files nil)

;; C-k cut and 
(setq kill-whole-line t)

;; set mac-keyboad's 'option' to meta-key
(setq mac-option-modifier 'meta)

;; C-h ---> back space
(global-set-key "\C-h" 'delete-backward-char)

;; set a window's alpha
(add-to-list 'default-frame-alist '(alpha.75))

;; set M-x goto-line --> M-g
(global-set-key "\eg" 'goto-line)

;; inverse C-x o
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))

;; auto fill
(add-hook 'text-mode-hook
          '(lambda () (auto-fill-mode 1)))
(setq text-mode-hook 'turn-off-auto-fill)

;; Off auto-new-line in YaTeX mode
(add-hook ' yatex-mode-hook 
 '(lambda () (auto-fill-mode -0)))



;; truncate long lines
(setq-default truncate-lines t)
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)


;; disable vc mode
(setq vc-handled-backends ())

;; ( --> ) 
;;(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(setq show-paren-style 'mixed)
(show-paren-mode t)

;; vertical border
;; Reverse colors for the border to have nicer line  
(set-face-background 'vertical-border (face-background 'mode-line))
(set-display-table-slot standard-display-table 
                        'vertical-border (make-glyph-code 8203))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; add load dir to load-path
;; (defun add-to-load-path (&rest paths)
;;   (let (path)
;;     (dolist (path paths paths)
;;      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
;;         (add-to-list 'load-path default-directory)
;;          (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;              (normal-top-level-add-subdirs-to-load-path))))))

;; add load dir
;;(add-to-load-path "load")
(add-to-list 'load-path "~/.emacs/load")
(load-file "~/.emacs.d/load/personal_setting.el")
(load-file "~/.emacs.d/load/latex-indent.el")
(load-file "~/.emacs.d/load/ftk-data-mode.el")
(load-file "~/.emacs.d/load/my-ediff-setting.el")
(load-file "~/.emacs.d/load/my-python-setting.el")
(load-file "~/.emacs.d/load/my-powerline-setting.el")



;; cask 
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)
(require 'package)
(package-initialize)


;; ;; color-theme
(use-package color-theme
  :config
  (color-theme-initialize)
  (load-file "~/.emacs.d/load/my-color-theme.el")
  (color-theme-masahiro)
  (set-face-attribute 'region nil :background "white" :foreground "black")
  (set-face-foreground 'highlight nil)
  )


;; ftk-data-mode
(autoload 'ftk-data-mode "ftk-data-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.dat\\(\\.txt\\)?\\'" . ftk-data-mode))



;; cmake mode
(use-package cmake-mode; Add cmake listfile names to the mode list.
  :config
  (setq auto-mode-alist  (append
                          '(("CMakeLists\\.txt\\'" . cmake-mode))
                          '(("\\.cmake\\'" . cmake-mode))
                          auto-mode-alist))
  (autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
  (add-hook 'cmake-mode-hook 'cmake-font-lock-activate)
  )

;; auto complete
(use-package auto-complete
  :config 
  (global-auto-complete-mode t)
  (setq ac-auto-start 2) 
  (setq ac-delay 0.1);;
  (setq ac-use-fuzzy t)
  (setq ac-use-comphist t)  ;;
  (setq ac-auto-show-menu 0.2)
  (add-to-list 'ac-modes 'yatex-mode)
  (add-to-list 'ac-modes 'text-mode)
)
;; undo tree
(use-package undo-tree
  :config
  (global-undo-tree-mode)
  )

;; python-mode
(use-package python-mode
  :ensure t
  :config
  (setq py-outline-minor-mode-p nil)
  ;; (setq py-indent-no-completion-p t)
  ;; (setq py-indent-honors-inline-comment t)
  ;; (setq py-tab-shifts-region-p t)
  (setq py-smart-indentation t)
  )




;; pallet to combine with cask and package
(use-package pallet)

;; ;; I don't know but ...
;; (use-package cl-lib
;;   :config 
;;   (defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
;;     "Prevent annoying \"Active processes exist\" query when you quit Emacs."
;;     (cl-letf (((symbol-function #'process-list) (lambda ())))
;;       ad-do-it)
;;     )
;;   )

;; powerline
(use-package powerline
  :config
  (powerline-default-theme-mod) ;; in color theme masahiro
  )
;; ediff
(use-package diff-mode
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq ediff-split-window-function 'split-window-horizontally)
)

;; markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
