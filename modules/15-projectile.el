(projectile-global-mode)
(counsel-projectile-mode)

(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-ripgrep)

(setq ripgrep-executable "noglob /usr/local/bin/rg")
(setq projectile-globally-ignored-files (append '("*.jpg" "*.png") projectile-globally-ignored-files))
