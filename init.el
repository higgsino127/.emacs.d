(setq inhibit-default-init t)                                        ;;; uncomment this line to disable loading of "default.el" at startup
(setq frame-title-format (concat  "%b - emacs@" (system-name)))      ;; default to better frame titles
(setq diff-switches "-u")                                            ;; default to unified diffs
(setq inhibit-startup-message t)                                     ;; Don't view start-up page
(menu-bar-mode -1)                                                   ;; Hide meanu bar
(setq-default tab-width 4 indent-tabs-mode nil)                      ;; tab ---->> spacex4
(setq indent-line-function 'indent-to-left-margin)                   ;; change tab behav
(setq delete-auto-save-files t)                                      ;; rm autofile at exit emacs 
(setq make-backup-files nil)                                         ;; don't make *~ file
(setq kill-whole-line t)                                             ;; C-k cut and 
(setq mac-option-modifier 'meta)                                     ;; set mac-keyboad's 'option' to meta-key
(setq completion-ignore-case t)                                      ;; Ignore Capital or not 
(global-set-key "\C-h" 'delete-backward-char)                        ;; C-h ---> back space
(add-to-list 'default-frame-alist '(alpha.75))                       ;; set a window's alpha
(global-set-key "\eg" 'goto-line)                                    ;; set M-x goto-line --> M-g
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1))) ;; inverse C-x o
(add-hook 'text-mode-hook '(lambda () (auto-fill-mode 1)))           ;; auto fill
(setq text-mode-hook 'turn-off-auto-fill)                            ;; auto fill
(add-hook ' yatex-mode-hook '(lambda () (auto-fill-mode -0)))        ;; Off auto-new-line in YaTeX mode
(setq-default truncate-lines t)                                      ;; truncate long lines
(global-set-key (kbd "C-c l") 'toggle-truncate-lines)                ;; truncate long lines
(setq vc-handled-backends ())                                        ;; disable vc mode
                                                                     ;; ( --> ) 
                                                                     ;;(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(setq show-paren-style 'mixed)
(show-paren-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
(when (equal system-type 'gnu/linux) ;; for Linux(lxplus)
  (require 'cask "~/.cask/cask.el")
  )
(when (equal system-type 'darwin) ;; for Mac
  (require 'cask "/usr/local/opt/cask/cask.el")
  )
(cask-initialize)
;; pallet to combine with cask and package
(require 'pallet)
(pallet-mode t)
(use-package pallet)
;;(require 'package)
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
;;undo hist
(use-package  undohist
 :config
 (undohist-initialize))

;; python-mode
(use-package python-mode
  :config
  ;; (setq py-indent-tabs-mode t)
  ;; (setq py-smart-indentation t)
  ;; (setq py-indent-no-completion-p t)
  (setq indent-tabs-mode nil)
  (setq indent-level 4)
  (setq python-indent 4)
  (setq tab-width 4)
  )
(add-hook 'python-mode-hook
	  '(lambda()
	     (setq indent-tabs-mode nil)
	     (setq indent-level 4)
	     (setq python-indent 4)))


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

(use-package yatex)
;; yatex
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code 4)
(setq YaTeX-latex-message-code 'utf-8)
(setq YaTeX-use-AMS-LaTeX t)
(setq YaTeX-dvi2-command-ext-alist
      '(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
(add-hook 'yatex-mode-hook '(lambda () (auto-fill-mode -1))) ;; without auto new  line

;; vertical border
(set-display-table-slot standard-display-table 
                        'vertical-border (make-glyph-code ?│))


;; vhdl mode
(setq vhdl-end-comment-column 9999)
(setq vhdl-inline-comment-column 9999)
(setq vhdl-intelligent-tab nil)
(setq vhdl-underscore-is-part-of-word t)
(setq vhdl-word-completion-in-minibuffer nil)
(setq vhdl-indent-comment-like-next-code-line nil)
(setq indent-line-function 'indent-to-left-margin)

;; ;; hightlight indent guide
;; (use-package highlight-indent-guides)
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;; (setq highlight-indent-guides-method 'character)
;; (setq highlight-indent-guides-character ?\│)

;; indent-guide
;; (use-package indent-guide
;;   :config
;;   (indent-guide-global-mode)
;;   (setq indent-guide-delay 0.1)
;;   ;;(setq indent-guide-char (make-glyph-code ?│))
;; )
