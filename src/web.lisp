(in-package :scs.web)


;;;
;;; Start-up
;;; 

(defvar *server* nil
  "Server instance.")
(defparameter *port* 8900
  "Application port.")

(defun build-assets ()
  "Triggers the NPM build script from inside Lisp."
  (uiop:run-program '("sh" "-c" "npm run build-css")
		    :directory (asdf:system-source-directory :scs)
		    :output t))

(defun serve-static-assets ()
  "Let hunchentoo serve static assets under the /src/static-files/ directory
of the system. Then reference static assets with the /static/ URL prefix."
  (push (hunchentoot:create-folder-dispatcher-and-handler
	 "/static/"
	 (asdf:system-relative-pathname :scs
					"static-files/"))
	hunchentoot:*dispatch-table*))

(defun start (&key
		(port *port*)
		(session-secret
		 (utils:config :session-secret "psst. replace me")))
  "Start web app."
  (format t "~&Starting the web server on port ~a~&" port)
  (force-output)
  ;; (connect)
  (serve-static-assets)

  (setf *server* (make-instance 'easy-routes:easy-routes-acceptor
				:port port
				:address "0.0.0.0"))

  (setf hunchentoot:*session-secret* session-secret)

  (hunchentoot:start *server*))

(defun stop ()
  "Stop web app."
  ;; (disconnect)
  (hunchentoot:stop *server*))

(defmethod hunchentoot:acceptor-status-message ((acceptor easy-routes:easy-routes-acceptor) http-status-code &key &allow-other-keys)
  "Custom error page handler for Hunchentoot. 
   Catches 404s after all routes and static file dispatchers fail."
  (if (= http-status-code hunchentoot:+http-not-found+)
      (views:display-404-page)
      (call-next-method)))
