(in-package :scs.views)


(defparameter *slide-duration* "900")

(defparameter *marquee-list*
  '("Professional"
    "Reliable"
    "Exceptional"
    "Immaculate"))


(defun display-home-page ()
  (with-page (:title (utils:config :business-name))
    (:div.d-flex.flex-column.gap-5
     :style "margin-bottom: -4rem;"
     (render-hero-section)
     (render-how-it-works)
     (render-marquee *marquee-list*
		     :feature-classes "display-3"
		     :del-classes "ms-1 me-5")
     (render-about-us-section))))

(defun display-about-us-page ()
  (with-page (:title "About Us")
    (page-banner "about us" '(("Home" . "/") ("About Us" . nil)))
    (render-about-us-section :btn-text "Contact Us Today"
                             :btn-link "/contact-us")))

(defun display-faq-page ()
  ;; Split the list in half for the 2 columns
  (let* ((half (ceiling (length *faqs*) 2))
         (left-faqs (subseq *faqs* 0 half))
         (right-faqs (subseq *faqs* half)))
    (with-page (:title "FAQ")
      (page-banner "frequently asked questions" 
		   '(("Home" . "/") ("FAQs" . nil)))
      
      (:div.faq-area-four.ptb-120
       (:div.container
        (:div.row.g-4
         (:div.col-lg-6
          (:div.accordion.faq-wrapper#accordionExample
           :data-cues "slideInUp" :data-duration *slide-duration*
           (loop for faq in left-faqs
                 for i from 1
                 do (faq-item (format nil "collapseLeft~A" i)
                              "accordionExample"
                              (getf faq :question)
                              (getf faq :answer)
                              :show (= i 1)))))
         (:div.col-lg-6
          (:div.accordion.faq-wrapper#accordionExample2
           :data-cues "slideInUp" :data-duration *slide-duration*
           (loop for faq in right-faqs
                 for i from 1
                 do (faq-item (format nil "collapseRight~A" i)
                              "accordionExample2"
                              (getf faq :question)
                              (getf faq :answer)))))))))))

(defun display-our-services-page ()
  (with-page (:title "Our Services")
    (page-banner "our services" 
		 '(("Home" . "/") ("Our Services" . nil)))
    
    (:div.services-area.ptb-120
     (:div.container.mw-1685
      (:div.row.g-4
       (loop for s in *services*
             do (:div.col-lg-4.col-md-6
		 (service-card (getf s :icon)
			       (getf s :title)
			       (getf s :desc)))))))))

(defun display-contact-us-page ()
  (with-page (:title "Contact Us")
    (page-banner "contact us" '(("Home" . "/") ("Contact Us" . nil)))
    (render-contact-us-section :include-spacer nil)))

(defun display-404-page ()
  (with-page (:title "404 - Page Not Found")
    (:div.text-center
     (:div.d-flex.flex-column.gap-2
      (:h1.main-title
       :style "font-size: 8rem; color: var(--primary-color);"
       "404")
      (:h2.mb-3 "Page Not Found")
      (:p "The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.")
      
      (:a.btn.btn-primary
       :href "/"
       (:div.d-flex.align-items-center.justify-content-center.g-2
	(:span "Back to Home")))))))
