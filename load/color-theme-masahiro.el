(eval-when-compile
  (require 'color-theme))



(defun color-theme-masahiro ()
  "Color theme by Masahiro Morinaga, created 2015-12-24.
Green on black, includes font-lock, show-paren, and ediff."
  (interactive)
  (color-theme-install
   '(color-theme-oswald
     ((background-color . "black")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "black")
      (foreground-color . "green")
      (mouse-color . "black"))
     ((blank-space-face . blank-space-face)
      (blank-tab-face . blank-tab-face)
      (list-matching-lines-face . bold)
      (view-highlight-face . highlight))
    (default ((t (nil))))
    (blank-space-face ((t (:background "LightGray"))))
    (blank-tab-face ((t (:background "green" :foreground "black"))))
    (bold ((t (:bold t))))
    (bold-italic ((t (:italic t :bold t))))
    (ediff-current-diff-face-A ((t (:background "pale green" :foreground "firebrick"))))
    (ediff-current-diff-face-Ancestor ((t (:background "VioletRed" :foreground "Black"))))
    (ediff-current-diff-face-B ((t (:background "Yellow" :foreground "DarkOrchid"))))
    (ediff-current-diff-face-C ((t (:background "Pink" :foreground "Navy"))))
    (ediff-even-diff-face-A ((t (:background "light grey" :foreground "Black"))))
    (ediff-even-diff-face-Ancestor ((t (:background "Grey" :foreground "White"))))
    (ediff-even-diff-face-B ((t (:background "Grey" :foreground "White"))))
    (ediff-even-diff-face-C ((t (:background "light grey" :foreground "Black"))))
    (ediff-fine-diff-face-A ((t (:background "sky blue" :foreground "Navy"))))
    (ediff-fine-diff-face-Ancestor ((t (:background "Green" :foreground "Black"))))
    (ediff-fine-diff-face-B ((t (:background "cyan" :foreground "Black"))))
    (ediff-fine-diff-face-C ((t (:background "Turquoise" :foreground "Black"))))
    (ediff-odd-diff-face-A ((t (:background "Grey" :foreground "White"))))
    (ediff-odd-diff-face-Ancestor ((t (:background "light grey" :foreground "Black"))))
    (ediff-odd-diff-face-B ((t (:background "light grey" :foreground "Black"))))
    (ediff-odd-diff-face-C ((t (:background "Grey" :foreground "White"))))
    (font-lock-builtin-face ((t (:italic t :bold t :foreground "LightSteelBlue"))))
    (font-lock-comment-face ((t (:italic t :foreground "LightGoldenrod4"))))
    (font-lock-constant-face ((t (:foreground "SkyBlue1"))))
    (font-lock-doc-string-face ((t (:italic t :foreground "orange"))))
    (font-lock-function-name-face ((t (:italic t :foreground "HotPink"))))
    (font-lock-keyword-face ((t (:foreground "firebrick1"))))
    (font-lock-preprocessor-face ((t (:italic t :foreground "red"))))
    (font-lock-string-face ((t (:italic t :foreground "orange"))))
    (font-lock-reference-face ((t (:italic t :bold t :foreground "LightSteelBlue"))))

    ;;(font-lock-type-face ((t (:italic t :foreground "DodgerBlue1"))))
    ;;(font-lock-variable-name-face ((t (:underline t :foreground "RoyalBlue1"))))
    ;;(font-lock-type-face ((t (:italic t :foreground "LightSeaGreen"))))
    (font-lock-type-face ((t (:italic t :foreground "SeaGreen3"))))
    (font-lock-variable-name-face ((t (:underline t :foreground "LightSeaGreen"))))
    
    (font-lock-warning-face ((t (:bold t :foreground "Pink"))))
    (font-lock-operator-face ((t (:foreground "gray"))))
    
    (mode-line          ((t (:background "gray10" :foreground "dim gray"))))
    (mode-line-inactive ((t (:background "gray10" :foreground "dim gray"))))
    (mode-line-sep          ((t (:background "dim gray" :foreground "gray10"))))
    (mode-line-inactive-sep ((t (:background "dim gray" :foreground "gray10"))))

    (powerline-active1    ((t (:background "dim gray" :foreground "gray10"))))
    (powerline-inactive1  ((t (:background "dim gray" :foreground "gray10"))))
    (powerline-active1-sep   ((t (:background "dark gray" :foreground "dim gray"))))
    (powerline-inactive1-sep ((t (:background "dark gray" :foreground "dim gray"))))

    (powerline-active2 ((t (:background "dim gray" :foreground "gray10"))))
    (powerline-inactive2 ((t (:background "dim gray" :foreground "gray10"))))


    
    
    (highlight ((t (:background "yellow" :foreground "red"))))
    (isearch ((t (:background "dim gray" :foreground "aquamarine"))))
    (ispell-face ((t (:bold t :background "#3454b4" :foreground "yellow"))))
    (italic ((t (:italic t))))
    (region ((t (:background "dim gray" :foreground "aquamarine"))))
    (secondary-selection ((t (:background "darkslateblue" :foreground "light goldenrod"))))
    (show-paren-match-face ((t (:background "turquoise" :foreground "White"))))
    (show-paren-mismatch-face ((t (:background "purple" :foreground "white"))))
    (underline ((t (:underline t))))
    )))





