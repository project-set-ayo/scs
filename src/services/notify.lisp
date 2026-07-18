(in-package :scs.services)


(defun get-email-config ()
  "Extracts and returns the email configuration as a plist."
  (list :host   (utils:config :email-host)
        :port   (utils:config :email-port 587)
        :sender (utils:config :email-default-sender)
        ;; If your provider requires a specific username (e.g., "emailapikey" for ZeptoMail),
        ;; set :email-user in config.lisp. Otherwise, defaults to the sender address.
        :user   (utils:config :email-user (utils:config :email-default-sender))
        :pass   (utils:config :email-secret-key)))

(defun send-email (to subject text-content &key html-content reply-to)
  "Core primitive to dispatch an email via cl-smtp. Composable and agnostic."
  (let* ((conf (get-email-config))
         (port (getf conf :port))
         ;; Port 465 uses direct TLS, Port 587 uses STARTTLS
         (ssl-type (if (= port 465) :tls :starttls)))
    
    (cl-smtp:send-email
     (getf conf :host)
     (getf conf :sender)
     to
     subject
     text-content
     :html-message html-content
     :reply-to reply-to
     :port port
     :ssl ssl-type
     :authentication (list (getf conf :user) (getf conf :pass)))))
