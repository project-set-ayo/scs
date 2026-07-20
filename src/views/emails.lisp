(in-package :scs.views)


(defmacro with-email-layout ((&key title) &body body)
  "A generic wrapper for consistent HTML email styling."
  `(with-html-string
     (:html
      (:head
       (:meta :charset "utf-8")
       (:title ,title))
      (:body :style "font-family: Arial, sans-serif; color: #333; line-height: 1.6; max-width: 600px; margin: 0 auto; padding: 20px;"
	     (:h2 :style "color: #556b2f;" ,title)
	     ,@body
	     (:hr :style "margin-top: 30px; border: 0; border-top: 1px solid #eee;")
	     (:p :style "font-size: 12px; color: #999;"
		 "This is an automated message from "
		 (:strong (utils:config :business-name))
		 ". Please do not reply directly to this notification.")))))

(defun normalize-message (message)
  "Splits text on any whitespace (including newlines) and joins with a single space."
  (format nil "~{~A~^ ~}" (str:words message)))

(defun generate-admin-inquiry-text (type name email phone subject message)
  "Generates plaintext notification for the business owner."
  (format nil "New ~A Received~%~%Name: ~A~%Email: ~A~%Phone: ~A~%Subject: ~A~%~%Message:~%~A~%"
          type name email phone subject (normalize-message message)))

(defun generate-admin-inquiry-html (type name email phone subject message)
  "Generates HTML notification for the business owner."
  (let ((title (format nil "New ~A Received" type)))
    (with-email-layout (:title title)
      (:p (:strong "Name: ") name)
      (:p (:strong "Email: ") (:a :href (format nil "mailto:~A" email) email))
      (:p (:strong "Phone: ") phone)
      (:p (:strong "Subject: ") subject)
      (:h4 :style "margin-bottom: 5px;" "Message:")
      (:p :style "white-space: pre-wrap; background: #f9f9f9; padding: 15px; border-radius: 5px; border: 1px solid #eee;"
          (normalize-message message)))))

(defun generate-user-confirmation-text (name)
  "Generates plaintext auto-reply for the user."
  (format nil "Dear ~A,~%~%Thank you for reaching out to ~A. We have received your message and a team member will be in touch shortly.~%~%Warm regards,~%The ~A Team~%"
          name (utils:config :business-name) (utils:config :business-name)))

(defun generate-user-confirmation-html (name)
  "Generates HTML auto-reply for the user."
  (with-email-layout (:title "We received your message")
    (:p (format nil "Dear ~A," name))
    (:p (format nil "Thank you for reaching out to ~A. We have received your message and a team member will be in touch shortly."
                (utils:config :business-name)))
    (:p "Warm regards," (:br)
        (:strong (format nil "The ~A Team" (utils:config :business-name))))))
