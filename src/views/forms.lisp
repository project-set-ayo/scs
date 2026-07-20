(in-package :scs.views)


(defun contact-us-form (&key success error)
  (with-html
    (when success
      (:div.alert.alert-success.mb-4
       "Thank you! Your message has been sent. We will be in touch shortly."))
    (when error
      (:div.alert.alert-danger.mb-4
       "We're sorry, but something went wrong while sending your message. Please try again or call us directly at "
       (:a.fw-bold.text-danger.text-decoration-none 
        :href (format nil "tel:~A" (utils:config :business-phone)) 
        (utils:config :business-phone))
       "."))
    (:form.contact-us-form
     :method "POST"
     :action "/contact-us"
     (:div.row.g-4
      (:div.col-lg-6 (:input.form-control.p-3 :type "text" :name "name" :placeholder "Name" :required t))
      (:div.col-lg-6 (:input.form-control.p-3 :type "email" :name "email" :placeholder "Email" :required t))
      (:div.col-lg-6 (:input.form-control.p-3 :type "text" :name "phone" :placeholder "Phone" :required t))
      (:div.col-lg-6 (:input.form-control.p-3 :type "text" :name "subject" :placeholder "Subject" :required t))
      (:div.col-lg-12 (:textarea.form-control.p-3 :name "message" :rows "7" :placeholder "Message" :required t))
      (:div.col-lg-12
       (:button.btn.btn-primary.btn-lg.w-100.fw-bold.text-light
        :type "submit"
        (:span.d-flex.gap-2.align-items-center.justify-content-center
         (:span "Send Message")
         (:i.bi.bi-send-fill))))))))
