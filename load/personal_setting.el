
;; word killing 
(defun kill-ring-save-current-word ()
  "Save current word to kill ring as if killed, but don't kill it."
  (interactive)
  (save-excursion
    (forward-char)
    (backward-sexp)
    (let ((pos (point)))
      (forward-sexp)
      (kill-ring-save pos (point)))
    )
  )
(global-set-key "\C-xw" 'kill-ring-save-current-word)

;; duplicate-line 
(defun duplicate-line (&optional numlines)
  "One line is duplicated wherever there is a cursor."
  (interactive "p")
  (let* ((col (current-column))
         (bol (progn (beginning-of-line) (point)))
         (eol (progn (end-of-line) (point)))
         (line (buffer-substring bol eol)))
    (while (> numlines 0)
      (insert "\n" line)
      (setq numlines (- numlines 1)))
    (move-to-column col)))

(define-key esc-map "Y" 'duplicate-line)

;; up/down by keeping cursol point
(defun scroll-up-in-place (n)
  (interactive "p")
  (previous-line n)
  (scroll-down n))

(defun scroll-down-in-place (n)
  (interactive "p")
  (next-line n)
  (scroll-up n))

(global-set-key "\M-p" 'scroll-up-in-place)
(global-set-key [M-up] 'scroll-up-in-place)
(global-set-key "\M-n" 'scroll-down-in-place)
(global-set-key [M-down] 'scroll-down-in-place)

;; swap display
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key [f2] 'swap-screen)
(global-set-key [S-f2] 'swap-screen-with-cursor)

(require 'font-lock)

(defvar font-lock-operator-face 'font-lock-operator-face)
(defface font-lock-operator-face  '((((type tty) (class color)) nil)
                                    (((class color) (background light))
                                     (:foreground "dark red"))
                                    (t nil))
  "Used for operators."
  :group 'font-lock-faces)

(defvar font-lock-end-statement-face 'font-lock-end-statement-face)
(defface font-lock-end-statement-face  '((((type tty) (class color)) nil)
                                         (((class color) (background light))
                                          (:foreground "DarkSlateBlue"))
                                         (t nil))
  "Used for end statement symbols."
  :group 'font-lock-faces)

(defvar font-lock-operator-keywords
  '(("\\([][|!.+=&/%*,<>(){}:^~-]+\\)" 1 font-lock-operator-face)
    (";" 0 font-lock-end-statement-face)))

(defun --copy-face (new-face face)
  "Define NEW-FACE from existing FACE."
  (copy-face face new-face)
  (eval `(defvar ,new-face nil))
  (set new-face new-face))

(--copy-face 'font-lock-label-face  ; labels, case, public, private, proteced, namespace-tags
             'font-lock-keyword-face)
(--copy-face 'font-lock-doc-markup-face ; comment markups such as Javadoc-tags
             'font-lock-doc-face)
(--copy-face 'font-lock-doc-string-face ; comment markups 
             'font-lock-comment-face)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(require 'cc-mode)
(add-hook 'c++-mode-hook
          '(lambda()
             (font-lock-add-keywords
              nil '(;; complete some fundamental keywords
                    ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
                    ;; add the new C++11 keywords
                    ("\\<\\(alignof\\|auto\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
                    ;; namespace names and tags - these are rendered as constants by cc-mode
                    ("\\<\\(\\w+::\\)" . font-lock-type-face)
                    ("\\<\\(char[0-9]+_t\\)\\>" . font-lock-keyword-face)
                    ;; PREPROCESSOR_CONSTANT
                    ("\\<[A-Z]+[A-Z_]+\\>" . font-lock-constant-face)
                    ;; hexadecimal numbers
                    ("\\<0[xX][0-9A-Fa-f]+\\>" . font-lock-constant-face)
                    ;; integer/float/scientific numbers
                    ("\\<[\\-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][\\-+]?[0-9]+\\)?\\>" . font-lock-constant-face)
                    ;; 1e+10...
                    ("\\<[\\-+]*[0-9]*[e]*[\\-+]?\\>" . font-lock-constant-face)
                    ;; user-types (customize!)
                    ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(t\\|type\\|ptr\\)\\>" . font-lock-type-face)
                    ("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
                    ("\\([][|!.+=&/%*,<>(){}:^~-]+\\)" 1 font-lock-operator-face)
                    ))
             ) t)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cxx\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.C\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.icc\\'" . c++-mode))

;;(autoload 'cc-mode "cc-mode" "C++11 editing mode." t)

(font-lock-add-keywords 'python-mode    '(("\\<\\(object\\|str\\|else\\|except\\|finally\\|try\\|\\)\\>" 0 py-builtins-face)  
                                        ; adds object and str and fixes it so that keywords that often appear with : are assigned as builtin-face
                                          ("\\<[\\+-]?[0-9]+\\(.[0-9]+\\)?\\>" 0 'font-lock-constant-face) 
                                        ; FIXME: negative or positive prefixes do not highlight to this regexp but does to one below
                                          ("\\([][{}()~^<>:=,.\\+*/%-]\\)" 0 'widget-active-face)))
