(in-package :scs.controllers)


(easy-routes:defroute home-page ("/" :method :get)
    ()
  (views:display-home-page))

(easy-routes:defroute our-services-page ("/our-services" :method :get)
    ()
  (views:display-our-services-page))

(easy-routes:defroute about-us-page ("/about-us" :method :get)
    ()
  (views:display-about-us-page))

(easy-routes:defroute contact-us-page ("/contact-us" :method :get) 
    ()
  (views:display-contact-us-page))

(easy-routes:defroute faq-page ("/faq" :method :get) 
    ()
  (views:display-faq-page))

(easy-routes:defroute contact-us-submit ("/contact-us" :method :post) 
    (&post name email phone subject message)
  ;; Trigger emails
  (process-inquiry-emails "Contact Request"
			  name
			  email
			  phone
			  subject
			  message)
  ;; Redirect user back to the GET page with a success flag
  (hunchentoot:redirect "/contact-us?success=true"))

(easy-routes:defroute faq-submit ("/faq" :method :post) 
    (&post name email phone subject message)
  (process-inquiry-emails "FAQ Question"
			  name
			  email
			  phone
			  subject
			  message)
  (hunchentoot:redirect "/faq?success=true"))

(easy-routes:defroute ping-route ("/ping" :method (:get :head :options))
    ()
  "Health check endpoint for monitoring services like UptimeRobot."
  (setf (hunchentoot:content-type*) "text/plain")
  "PONG")


(defun process-inquiry-emails (inquiry-type name user-email phone subject message)
  "Composes templates and dispatches both the admin notification and user confirmation."
  (let ((business-email (utils:config :business-email)))
    
    ;; 1. Send Notification to Business Owner
    (services:send-email 
     business-email
     (format nil "[~A] ~A" inquiry-type subject)
     (views:generate-admin-inquiry-text inquiry-type
					name
					user-email
					phone
					subject
					message)
     :html-content (views:generate-admin-inquiry-html inquiry-type
						      name
						      user-email
						      phone
						      subject
						      message)
     :reply-to user-email)
    
    ;; 2. Send Auto-Reply Confirmation to the User
    (services:send-email 
     user-email
     (format nil "We received your message - ~A" (utils:config :business-name))
     (views:generate-user-confirmation-text name)
     :html-content (views:generate-user-confirmation-html name))))
