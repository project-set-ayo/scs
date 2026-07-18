(in-package :scs.views)


(defun contact-us-form (&key success)
  (with-html
    (when success
      (:div.alert.alert-success.mb-4
       "Thank you! Your message has been sent. We will be in touch shortly."))
    (:form.contact-us-form
     :method "POST"
     :action "/contact-us"
     (:div.row.g-4
      (:div.col-lg-6 (:input.form-control :type "text"
					  :name "name"
					  :placeholder "Name"
					  :required t))
      (:div.col-lg-6 (:input.form-control :type "email"
					  :name "email"
					  :placeholder "Email"
					  :required t))
      (:div.col-lg-6 (:input.form-control :type "text"
					  :name "phone"
					  :placeholder "Phone"
					  :required t))
      (:div.col-lg-6 (:input.form-control :type "text"
					  :name "subject"
					  :placeholder "Subject"
					  :required t))
      (:div.col-lg-12 (:textarea.form-control :name "message"
					      :rows "7"
					      :placeholder
					      "Message"
					      :required t))
      (:div.col-lg-12
       (:button.default-btn.w-100
	:type "submit"
	(:span.d-flex.gap-10.align-items-center.justify-content-center
	 (:span "send message")
	 (:i.bi.bi-arrow-right :style "font-size: 1.5rem;"))))))))
