(add-hook 'cider-mode-hook
  (lambda ()
    (paredit-mode +1)
    (define-key cider-mode-map [f12] 'cider-eval-buffer)))
