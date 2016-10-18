(defvar my-packages '(auctex cider solarized-theme paredit markdown-mode ess inf-ruby csv-nav typo nav coffee-mode haml-mode))

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load-theme 'deeper-blue 1) ; deep-blue 1) ; adwaita 1) ; wombat 1) ; solarized-dark 1)

;; Paredit
(add-hook 'cider-mode-hook
  (lambda ()
    (paredit-mode +1)
    (cider-turn-on-eldoc-mode)
    (define-key cider-mode-map [f12] 'cider-eval-buffer)))

;; full screen
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key [f11] 'toggle-fullscreen)

;; misc
(require 'ido)
(ido-mode t)
(show-paren-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(setq display-time-24hr-format t)
(setq inhibit-startup-message t)
(setq visible-bell t)
(setq-default indent-tabs-mode nil)
(set-default-font "Ubuntu Mono-18")
;; (display-time)

;; tell Gnus where we have the config file
(setq gnus-init-file "~/.emacs.d/gnus")

(require 'ess)
;; from http://blog.anghyflawn.net/2014/07/12/getting-ess-and-auctex-to-play-nicely-with-knitr/
(setq ess-swv-processor 'knitr)
;; somewhere after (require 'ess-site)
(setq ess-swv-plug-into-AUCTeX-p t)

(defun ess-swv-add-TeX-commands ()
  "Add commands to AUCTeX's \\[TeX-command-list]."
  (unless (and (featurep 'tex-site) (featurep 'tex))
    (error "AUCTeX does not seem to be loaded"))
  (add-to-list 'TeX-command-list
               '("Knit" "Rscript -e \"library(knitr); knit('%t')\""
                 TeX-run-command nil (latex-mode) :help
                 "Run Knitr") t)
  (add-to-list 'TeX-command-list
               '("LaTeXKnit" "%l %(mode) %s"
                 TeX-run-TeX nil (latex-mode) :help
                 "Run LaTeX after Knit") t)
  (setq TeX-command-default "Knit")
  (mapc (lambda (suffix)
          (add-to-list 'TeX-file-extensions suffix))
        '("nw" "Snw" "Rnw")))

(defun ess-swv-remove-TeX-commands (x)
  "Helper function: check if car of X is one of the Knitr strings"
  (let ((swv-cmds '("Knit" "LaTeXKnit")))
    (unless (member (car x) swv-cmds) x)))

(defun clear-shell ()
  (interactive)
  (if (eql major-mode 'cider-repl-mode)
      (cider-repl-clear-buffer)
    (let ((old-max comint-buffer-maximum-size))
      (setq comint-buffer-maximum-size 0)
      (comint-truncate-buffer)
      (setq comint-buffer-maximum-size old-max))))

(global-set-key (kbd "\C-x c") 'clear-shell)
(global-set-key (kbd "\C-x j") 'ace-jump-word-mode)

(add-hook 'markdown-mode-hook 'visual-line-mode)
(add-hook 'markdown-mode-hook 'typo-mode)
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'text-mode-hook 'typo-mode)
(put 'downcase-region 'disabled nil)

(dolist (x '("\\.rake$" "\\.gemspec$" "\\.ru$" "\\.rjs$" "Rakefile$" "Gemfile$" "Capfile$" "Vagrantfile$" "\\.rabl"))
  (add-to-list 'auto-mode-alist (cons x 'ruby-mode)))

(add-to-list 'auto-mode-alist '("\\.Rmd$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.hamlc$" . haml-mode))

(projectile-global-mode)
(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)
(setq projectile-globally-ignored-files (append '("*.jpg" "*.png") projectile-globally-ignored-files))

(setq js-indent-level 2)

(require 'rinari)

(server-start)

(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)

;; (setq create-lockfiles nil)

(setq-default c-basic-offset 4
              c-default-style "linux")

(defvar bjk-timestamp-format "%Y-%m-%d %H:%M"
  "Format of date to insert with `bjk-timestamp' function
%Y-%m-%d %H:%M will produce something of the form YYYY-MM-DD HH:MM
Do C-h f on `format-time-string' for more info")

(defun bjk-timestamp ()
  "Insert a timestamp at the current point.
Note no attempt to go to beginning of line and no added carriage return.
Uses `bjk-timestamp-format' for formatting the date/time."
  (interactive)
  (insert (format-time-string bjk-timestamp-format (current-time))))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("6394ba6170fd0bc9f24794d555fa84676d2bd5e3cfd50b3e270183223f8a6535" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(safe-local-variable-values (quote ((sgml-basic-offset . 4) (encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
