;; Usage: emacs -diff file1 file2
(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (ediff file1 file2)))
(add-to-list 'command-switch-alist '("diff" . command-line-diff))
(setq ediff-diff-options "-w")
(setq ediff-diff-options "-b")
(setq-default ediff-ignore-similar-regions t)
(setq-default ediff-auto-refine 'on)

;; ediff for git mergetool
(eval-after-load "ediff"
  '(progn
     ; save and restore window configuration
     (defvar my-ediff-saved-window-configuration nil "Saved window configuration for ediff")
     (defun my-ediff-save-window-configuration ()
       (setq my-ediff-saved-window-configuration (current-window-configuration)))
     (add-hook 'ediff-before-setup-hook 'my-ediff-save-window-configuration)
     (defun my-ediff-restore-window-configuration ()
       (set-window-configuration my-ediff-saved-window-configuration))
     (add-hook 'ediff-suspend-hook 'my-ediff-restore-window-configuration t)
     (add-hook 'ediff-quit-hook 'my-ediff-restore-window-configuration t)))
(eval-after-load "ediff"
  '(progn
     ; batch mode (for use from git mergetool etc.)
     (ediff-defvar-local my-ediff-batch-mode-p nil "True if in batch mode")
     (ediff-defvar-local my-ediff-close-on-quit nil "True if the buffer should be closed on quit.")
 
     (defun my-ediff-batch-mode (&optional mode)
       (ediff-with-current-buffer ediff-buffer-A
                                  (case mode
                                    (set
                                     (setq my-ediff-batch-mode-p t))
                                    (unset
                                     (prog1 my-ediff-batch-mode-p
                                       (setq my-ediff-batch-mode-p nil)))
                                    (t
                                     my-ediff-batch-mode-p))))
 
     (defadvice ediff-find-file (around
                                 mark-newly-opened-buffers
                                 (file-var buffer-name &optional last-dir hooks-var)
                                 activate)
       (let* ((file (symbol-value file-var))
              (existing-p (and find-file-existing-other-name
                               (find-buffer-visiting file))))
         ad-do-it
         (or existing-p
             (ediff-with-current-buffer (symbol-value buffer-name)
                                        (setq my-ediff-close-on-quit t)))))
 
     (defun my-ediff-save-merge ()
       (if (my-ediff-batch-mode)
           (let ((file ediff-merge-store-file))
             (if file
                 (ediff-with-current-buffer ediff-buffer-C
                   (set-visited-file-name file t)
                   (save-buffer))))
         (ediff-maybe-save-and-delete-merge)))
 
     (remove-hook 'ediff-quit-merge-hook 'ediff-maybe-save-and-delete-merge)
     (add-hook 'ediff-quit-merge-hook 'my-ediff-save-merge)
 
     (defadvice ediff-cleanup-mess (around
                                    support-batch-mode
                                    ()
                                    activate)
       (let ((batch-p (my-ediff-batch-mode 'unset))
             (buffers (list ediff-buffer-A ediff-buffer-B ediff-ancestor-buffer))
             (buffer-C ediff-buffer-C))
         ad-do-it
         (dolist (buffer buffers)
           (ediff-with-current-buffer buffer
             (and my-ediff-close-on-quit (kill-buffer))))
         (when batch-p
           (ediff-kill-buffer-carefully buffer-C)
           (delete-frame))))
 
     (defun ediff-merge-files-with-ancestor-in-batch-mode
       (file-A file-B file-ancestor &optional startup-hooks merge-buffer-file)
       (ediff-merge-files-with-ancestor
        file-A file-B file-ancestor
        (cons (function (lambda () (my-ediff-batch-mode 'set))) startup-hooks)
        merge-buffer-file))))
 
(autoload 'ediff-merge-files-with-ancestor-in-batch-mode "ediff")
