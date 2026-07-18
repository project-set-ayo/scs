(in-package :scs.utils)


(defvar *config* nil)

(defun load-config (path)
  "Load configuration from a Lisp plist file."
  (when (probe-file path)
    (setf *config* (uiop:read-file-form path))))

(defun config (key &optional default)
  "Fetch a config value, falling back to default."
  (if *config*
      (getf *config* key default)
      default))

