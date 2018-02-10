;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:


;;; Code:


(defface  ftk-data-mode-key1-face '((t (:foreground "red1"  ))) "Face for highlighting 'keyward1'.") ;;  for b0f
(defface  ftk-data-mode-key2-face '((t (:foreground "red" ))) "Face for highlighting 'keyward2'.") ;; for  e0f
(defface  ftk-data-mode-key3-face '((t (:foreground "green" ))) "Face for highlighting 'keyward3'.") ;; for trailar
(defface  ftk-data-mode-key4-face '((t (:foreground "blue" ))) "Face for highlighting 'keyward4'.") ;; for header
(defface  ftk-data-mode-key5-face '((t (:foreground "yellow" ))) "Face for highlighting 'keyward5'.") ;; for module header
(defvar   ftk-data-mode-key1-face 'ftk-data-mode-key1-face)
(defvar   ftk-data-mode-key2-face 'ftk-data-mode-key2-face)
(defvar   ftk-data-mode-key3-face 'ftk-data-mode-key3-face)
(defvar   ftk-data-mode-key4-face 'ftk-data-mode-key4-face)
(defvar   ftk-data-mode-key5-face 'ftk-data-mode-key5-face)

(defconst ftk-data-font-lock-keywords1
  (list
   (cons "[^\s]*b0f00000" 'ftk-data-mode-key1-face)
   (cons "[^\s]*e0f00000" 'ftk-data-mode-key2-face)
   (cons "[^\s]*e0da000." 'ftk-data-mode-key3-face)
   (cons "[^\s]*e0daf00." 'ftk-data-mode-key3-face)
   (cons "[^\s]*e0da001." 'ftk-data-mode-key3-face)
   (cons "[^\s]*c2cc0de0" 'ftk-data-mode-key3-face)
   (cons "[^\s]*2e5e27ed" 'ftk-data-mode-key4-face)
   (cons "[^\s]*ff1234ff" 'ftk-data-mode-key4-face)
   (cons "[^\s]*8000*"    'ftk-data-mode-key5-face)
   (cons "[^\s]*40000000" 'ftk-data-mode-key5-face)
   )
  )

;;;###autoload
(define-derived-mode ftk-data-mode fundamental-mode "ftk-data-mode"
  "Major mode for the ftk data format"
  ;; code for syntax highlighting  
  (setq font-lock-defaults '((ftk-data-font-lock-keywords1 )))
  ;;(setq font-lock-defaults '((ftk-data-font-lock-keywords1 )))

  )

;; add the mode to the `features' list(provide 'ftk-data-mode)

;;; ftk-data-mode.el ends here






