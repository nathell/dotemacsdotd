(defvar my-packages '(cider solarized-theme paredit markdown-mode ess))

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/")) 

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load-theme 'solarized-dark 1)

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

(global-set-key [f11] 'toggle-fullscreen)

;; misc
(iswitchb-mode 1)
(show-paren-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(setq display-time-24hr-format t)
(setq inhibit-startup-message t)
(setq visible-bell t)
(setq-default indent-tabs-mode nil)
(set-default-font "Ubuntu Mono-12")
;; (display-time)

;; tell Gnus where we have the config file
(setq gnus-init-file "~/.emacs.d/gnus")

(require 'ess)
