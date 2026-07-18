(in-package :asdf-user)


(defsystem "scs"
  :version "0.0.1"
  :author "Ayo <mail@ayoonipe.com>"
  :license ""
  :description "Website for shinite cleaning services."
  :depends-on (;; web stack
	       :hunchentoot
	       :easy-routes
	       :spinneret

	       ;; mail
	       :cl-smtp

	       ;; utilities
               :access
               :cl-ppcre
               :cl-slug
               :local-time
               :local-time-duration
               :log4cl
               :str
	       :uuid
	       :cl-dotenv
	       :slynk

	       ;; scripting
	       :unix-opts

	       ;; dev
	       :closer-mop)
  :components ((:module "src"
		:serial t
                :components
                ((:file "packages")
		 (:file "utils")
		 (:module "services"
		  :serial t
		  :components
		  ((:file "notify")))
		 (:module "views"
		  :serial t			  
		  :components
		  ((:file "utils")
		   (:file "components")
		   (:file "layout")
		   (:file "forms")
		   (:file "emails")
		   (:file "pages")))
		 (:file "controllers")
		 (:file "web")
		 (:file "main")))))
