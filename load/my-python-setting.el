(setq auto-mode-alist
      (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(font-lock-add-keywords 'python-mode    '(("\\<\\(object\\|str\\|else\\|except\\|finally\\|try\\|\\)\\>" 0 py-builtins-face)
                                        ; adds object and str and fixes it so that keywords that often appear with : are assigned as builtin-face
                                          ("\\<[\\+-]?[0-9]+\\(.[0-9]+\\)?\\>" 0 'font-lock-constant-face)
                                        ; FIXME: negative or positive prefixes do not highlight to this regexp but does to one below
                                          ("\\([][{}()~^<>:=,.\\+*/%-]\\)" 0 'widget-active-face)))


