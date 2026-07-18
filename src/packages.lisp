;;;
;;; define helper packages,
;;; the models,
;;; the web,
;;; and the base package that relies on all of them.
;;;

(defpackage scs.utils
  (:use #:cl
	#:log4cl)
  (:export #:format-date
	   #:i18n-load
	   #:_
	   #:empty->nil
	   #:parse-int
	   #:parse-decimal
	   #:format-id
	   #:format-decimal
	   #:format-price
	   #:parse-iso-date
	   #:*config*
	   #:config
	   #:load-config)
  (:local-nicknames (#:a #:alexandria))
  (:documentation "Utilities that do not depend on models."))

(defpackage scs.models
  (:use :cl)
  (:export #:connect
	   #:disconnect
	   #:with-db-connection
	   #:migrate-db)
  (:local-nicknames (#:a #:alexandria)
		    (#:utils #:scs.utils))
  (:documentation "Models for store system."))

(defpackage scs.services
  (:use :cl)
  (:export #:send-email)
  (:local-nicknames (#:utils #:scs.utils)
		    (#:models #:scs.models))
  (:documentation "System services."))

(defpackage scs.views
  (:use #:cl
	#:spinneret)
  (:export ;;
					;#:make-flash
					;#:display-flash
   ;; pages
					;#:display-500-page
   #:display-404-page
   #:display-home-page
   #:display-our-services-page
   #:display-about-us-page
   #:display-faq-page
   #:display-contact-us-page
   ;; partials 
   ;; components
   ;; emails
   #:generate-admin-inquiry-text
   #:generate-admin-inquiry-html
   #:generate-user-confirmation-text
   #:generate-user-confirmation-html
   ;; utils
					;#:set-flash
					;#:pop-flash
   )
  (:local-nicknames (#:a #:alexandria)
		    (#:models #:scs.models)
		    (#:services #:scs.services)
		    (#:utils #:scs.utils))
  (:documentation "Views for store system."))

(defpackage scs.controllers
  (:use :cl)
  (:local-nicknames (#:a #:alexandria)
		    (#:models #:scs.models)
		    (#:services #:scs.services)
		    (#:views #:scs.views)
		    (#:utils #:scs.utils))
  (:documentation "Controllers for store system."))

(defpackage scs.web
  (:use #:cl
	#:spinneret)
  (:import-from #:easy-routes
		#:defroute)
  (:import-from #:scs.models
		#:with-db-connection
		#:connect
		#:disconnect)
  (:export #:start
	   #:stop
	   #:build-assets)
  (:local-nicknames (#:a #:alexandria)
		    (#:controllers #:scs.controllers)
		    (#:views       #:scs.views)
		    (#:utils #:scs.utils))
  (:documentation "Web-interface for store system."))

(defpackage scs
  (:use #:cl
	#:log4cl)
  (:export #:main
	   #:run)
  (:local-nicknames (#:a #:alexandria)
		    (#:models #:scs.models)
		    (#:web #:scs.web)
		    (#:utils #:scs.utils))
  (:documentation "Main package for store system."))
