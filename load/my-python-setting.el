

;; (font-lock-add-keywords 'python    '(("\\<\\(object\\|str\\|else\\|except\\|finally\\|try\\|\\)\\>" 0 py-builtins-face)
;;                                         ; adds object and str and fixes it so that keywords that often appear with : are assigned as builtin-face
;;                                           ("\\<[\\+-]?[0-9]+\\(.[0-9]+\\)?\\>" 0 'font-lock-constant-face)
;;                                         ; FIXME: negative or positive prefixes do not highlight to this regexp but does to one below
;; ;;                                           ("\\([][{}()~^<>:=,.\\+*/%-]\\)" 0 'widget-active-face)))



(defvar font-lock-operator-face 'font-lock-operator-face)
(defvar font-lock-operator-keywords
  '(("\\([][|!.+=&/%*,<>(){}:^~-]+\\)" 1 font-lock-operator-face)
    (";" 0 font-lock-end-statement-face)
    ))

(add-hook 'python-mode-hook
          '(lambda ()
             (font-lock-add-keywords nil  '(("\\<\\(object\\|str\\|else\\|except\\|finally\\|try\\|\\)\\>" 0 py-builtins-face)
                                            ;; adds object and str and fixes it so that keywords that often appear with : are assigned as builtin-face
                                            ("\\<[\\+-]?[0-9]+\\(.[0-9]+\\)?\\>" 0 'font-lock-constant-face);; default value
                                            ("0x\\([0-9a-fA-F]+\\)" 0 'font-lock-constant-face);; hex
                                            ;; FIXME: negative or positive prefixes do not highlight to this regexp but does to one below
                                            ("\\([][{}()~^<>:=,.\\+*/%-]\\)" 0 'font-lock-operator-face)))
             )
          )

