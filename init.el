(setf package-selected-packages
      '(ace-jump-mode
        ace-window
        cider
        color-theme-sanityinc-tomorrow
        company
        counsel
        counsel-projectile
        magit
        markdown-mode
        paredit
        pass
        projectile
        projectile-ripgrep
        typo))

;; run M-x package-install-selected-packages on startup

(defun load-directory (directory)
  "Load recursively all `.el' files in DIRECTORY."
  (dolist (element (directory-files-and-attributes directory nil nil nil))
    (let* ((path (car element))
           (fullpath (concat directory "/" path))
           (isdir (car (cdr element)))
           (ignore-dir (or (string= path ".") (string= path ".."))))
      (cond
       ((and (eq isdir t) (not ignore-dir))
        (load-directory fullpath))
       ((and (eq isdir nil) (string= (substring path -3) ".el"))
        (load (file-name-sans-extension fullpath)))))))

(load-directory "~/.emacs.d/modules")
