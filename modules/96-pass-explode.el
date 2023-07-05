(defun pass-explode ()
  (interactive)
  (let* ((password (buffer-string))
         (start 0)
         (end (1- (length password)))
         (password (substring password start end))
         (buffer (get-buffer-create "*exploded-password*")))
    (set-text-properties start end nil password)
    (with-current-buffer buffer
      (erase-buffer)
      (insert (replace-regexp-in-string "." "\\&\n" password))
      (linum-mode 1)
      (read-only-mode 1)
      (local-set-key "q" (lambda () (interactive) (kill-buffer))))
    (switch-to-buffer buffer)))

(defun my-pass-view-mode-hook ()
  (define-key pass-view-mode-map (kbd "C-c C-x") 'pass-explode))

(add-hook 'pass-view-mode-hook 'my-pass-view-mode-hook)