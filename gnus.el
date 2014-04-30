(setq gnus-select-method
      '(nnimap "dj@danieljanus.pl"
	       (nnimap-address "danieljanus.pl")
	       (nnimap-server-port 993)
	       (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      user-mail-address "dj@danieljanus.pl"
      smtpmail-starttls-credentials '(("danieljanus.pl" 587 nil nil))
      smtpmail-auth-credentials '(("danieljanus.pl" 587
				   "dj@danieljanus.pl" nil))
      smtpmail-default-smtp-server "danieljanus.pl"
      smtpmail-smtp-server "danieljanus.pl"
      smtpmail-smtp-service 587)

(defun gnus-summary-move-to-spambox ()
  "Move this article to the spambox."
  (interactive)
  (save-excursion
    (gnus-summary-mark-as-expirable 1))
  (gnus-summary-move-article 1 "INBOX.Spam")
  (forward-line 1))

(add-hook 'gnus-summary-mode-hook
          (lambda ()
            (define-key gnus-summary-mode-map
              [?s] 'gnus-summary-move-to-spambox)))

