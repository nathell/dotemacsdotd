(load-theme 'sanityinc-tomorrow-blue 1)
(show-paren-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(set-frame-font
 (pcase system-name
   ("karypel" "Ubuntu Mono-16")
   (_ "Inconsolata-18")))
(setq-default indent-tabs-mode nil)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 3
   kept-old-versions 2
   version-control t
   display-time-24hr-format t
   inhibit-startup-message t
   ring-bell-function 'ignore)
