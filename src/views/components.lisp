(in-package :scs.views)


(defparameter *links*
  '(("/" "Home")
    ("/our-services" "Our Services")
    ("/about-us" "About Us")
    ("/contact-us" "Contact Us")
    ("/faq" "FAQ")))


(defun site-header ()
  "Generates the top bar and main navigation."
  (with-html
    (:div.fixed-top.bg-light
     (:nav.navbar.navbar-expand-lg#navbar
      (:div.container.d-flex.align-items-center.justify-content-between
       (:a.navbar-brand
	:href "/"
	(:img.main-logo
	 :src "/static/images/logo.png"
	 :alt "logo"
	 :style "width: 3rem;"))

       (:div.d-flex.align-items-center.gap-3
	(:div.collapse.navbar-collapse#navbarSupportedContent
	 (:ul.navbar-nav.m-auto
	  (dolist (l *links*)
	    (:li.nav-item
	     (:a.nav-link :href (car l) (cadr l))))))
	
	(:a.btn.btn-primary.fw-bold.text-light
	 :href "/contact-us"
	 "Book Now")
	
	(:a.navbar-toggler
	 :data-bs-toggle "offcanvas"
	 :href "#offcanvasExample"
	 :role "button"
	 (:span.navbar-toggler-icon))))))))

(defun offcanvas-menus ()
  "Renders the mobile nav, right sidebar info, and search modal."
  (with-html
    ;; Mobile Navbar Offcanvas
    (:div.mobile-navbar.offcanvas.offcanvas-end.border-0
     :tabindex "-1"
     :id "offcanvasExample"
     (:div.offcanvas-header
      (:div
       (:a.logo.d-inline-block
	:href "/"
	(:img.main-logo
	 :src "/static/images/logo.png"
	 :alt "logo"
	 :style "width: 2.5rem;")))
      
      (:button.btn-close.opacity-1
       :type "button"
       :data-bs-dismiss "offcanvas"))
     
     (:div.offcanvas-body
      (:ul.list-group.list-group-flush.mb-3
       (dolist (l *links*)
	 (:li.list-group-item
	  (:a.nav-link :href (car l) (cadr l)))))
      
      (display-call-to-order-widget
       (utils:config :business-phone)
       :msg (utils:config :business-phone))))))

(defun site-footer ()
  "Generates the global footer."
  (with-html
    (:div.py-5.text-light
     :style "background-color: #03254F;"
     (:div.container.d-flex.flex-wrap.gap-5.justify-content-between
      (:div.d-flex.flex-column.gap-2
       (:span.h5.fw-bold "What are you waiting for?")
       (:span.h4.fst-italic "Experience the Elite")
       (:div.bg-light-subtle.rounded
	(display-call-to-order-widget
	 (utils:config :business-phone)
	 :msg (utils:config :business-phone))))
      
      (:div.d-flex.flex-wrap.gap-5
       (:div.d-flex.flex-column.gap-2
	(:span.h5.fw-bold "Site Map")
	(dolist (l *links*)
	  (:span
	   (:a.nav-link :href (car l) (cadr l)))))
       
       (:div.d-flex.flex-column.gap-2
	(:span.h5.fw-bold "Our Services")
	(dolist (l *services*)
	  (:span (cadr l))))

       (:div.d-flex.flex-column.gap-2
	(:span.h5.fw-bold "Service Locations")
	(:span "Barrhaven")
	(:span "Kanata")
	(:span "Orleans")
	(:span "Ottawa")
	(:span "Nepean " (:span.small "and more!"))))))

    (:div.bg-light-subtle.py-3
     (:div.container.d-flex.flex-wrap.justify-content-center.justify-content-lg-between.align-items-center
      (:p.mb-0
       "© "
       (:span.text-titlecase.fw-bold
	(utils:config :business-name))
       " All Rights Reserved.")))))

(defun info-widget ()
  (with-html
    (:div.footer-single-widget.d-flex.flex-column.gap-3
     (:div.text-center
      (:a.logo
       :href "/"
       (:img :src "/static/images/logo.png"
	     :alt "logo"
	     :style "width: 4.5rem;")))
     (:ul.p-0.m-0.list-unstyled.info-list
      (:li.d-flex
       (:div.flex-shrink-0 (:i.bi.bi-geo-alt-fill :style "color: var(--primary-color); font-size: 1.5rem;"))
       (:div.flex-grow-1
	(:h6 "Location")
	(:p (utils:config :business-address ""))))
      (:li.d-flex
       (:div.flex-shrink-0 (:i.bi.bi-envelope-fill :style "color: var(--primary-color); font-size: 1.5rem;"))
       (:div.flex-grow-1
	(:h6 "Email")
	(:a :href (format nil "mailto:~A" (utils:config :business-email))
	    (utils:config :business-email))))
      (:li.d-flex
       (:div.flex-shrink-0 (:i.bi.bi-telephone-fill :style "color: var(--primary-color); font-size: 1.5rem;"))
       (:div.flex-grow-1
	(:h6 "Phone")
	(:a :href (format nil "tel:~A" (utils:config :business-phone))
	    (utils:config :business-phone))))))))

(defun render-hero-section ()
  (with-html
    (:section.position-relative
     (:div.carousel.slide.carousel-fade#heroCarousel
      :data-bs-ride "carousel"
      (:div.carousel-inner
       (:div.carousel-item.active
	(:img.d-block.w-100
	 :src "/static/images/hero-cleaning-equipment.png"
	 :style "height: 85vh; object-fit: cover; filter: brightness(40%);"))
       (:div.carousel-item
	(:img.d-block.w-100
	 :src "/static/images/hero-countertop.png"
	 :style "height: 85vh; object-fit: cover; filter: brightness(40%);"))
       (:div.carousel-item
	(:img.d-block.w-100
	 :src "/static/images/hero-afterservice.png"
	 :style "height: 85vh; object-fit: cover; filter: brightness(40%);"))))

     (:div.position-absolute.top-0.start-0.w-100.h-100.d-flex.align-items-center.z-2.text-white
      (:div.container.d-flex.justify-content-start
       (:div.d-flex.flex-column.gap-4
	(:span.display-1 "Experience the Elite")
	(:span.subtitle.w-50 "We don't just clean spaces - we create healthy, spotless environments you can trust. Whether it's your home or your office, we take care of the details so you can enjoy your space. We clean, you relax.")
	(:div.d-flex.align-items-center.gap-3
	 (:a.btn.btn-primary.fw-bold
	  :href "/contact-us"
	  "Get a Free Estimate")
	 (:a.btn.btn-secondary.fw-bold
	  :href "/our-services"
	  "Our Services"
	  (:i.bi.bi-arrow-right-circle-fill.ms-2)))))))))

(defun render-how-it-works ()
  (with-html
    (:div.container.d-flex.flex-column.gap-5
     :data-cues "slideInUp" :data-duration "900"
     (:span.display-3.fw-bold.text-center "How it Works")
     
     (:div.d-flex.justify-content-evenly.align-items-baseline.gap-3
      (:div.card.border-0.text-center.mb-3
       :style "width: 16rem;"
       (:img.card-img-top
	:src "/static/images/calendar.png")
       (:div.card-body
	(:h5.card-title "Book a Day")
	(:p.card-text "Select a date & time for service.")))
      
      (:div.card.border-0.text-center.mb-3
       :style "width: 18rem;"
       (:img.card-img-top
	:src "/static/images/broom.png"
	:style "font-size: 1.5rem;")
       (:div.card-body
	(:h5.card-title "We Clean")
	(:p.card-text "Our team visits and leaves the space spotless!")))
      
      (:div.card.border-0.text-center.mb-3
       :style "width: 18rem;"
       (:img.card-img-top
	:src "/static/images/joy.png"
	:style "font-size: 1.5rem;")
       (:div.card-body
	(:h5.card-title "You Enjoy")
	(:p.card-text "Kick-back and enjoy your space.")))))))

(defun service-item (icon title)
  (with-html
    (:a.d-flex.align-items-center.services-single-item.text-decoration-none
     :href "/our-services"
     (:div.flex-shrink-0
      (:div.icon.rounded-circle.d-flex.justify-content-center.align-items-center
       (:img :src icon :alt "service")))
     (:div.flex-grow-1
      (:h3 title)))))

(defun faq-item (target parent question answer &key show)
  (with-html
    (:div.accordion-item
     (:h2.accordion-header
      (:button :class (if show "accordion-button"
			  "accordion-button collapsed")
               :type "button"
               :data-bs-toggle "collapse"
               :data-bs-target (concatenate 'string "#" target)
               :aria-expanded (if show "true" "false")
               :aria-controls target
               question))
     (:div :id target
           :class (if show "accordion-collapse collapse show"
		      "accordion-collapse collapse")
           :data-bs-parent (concatenate 'string "#" parent)
	   (:div.accordion-body
	    (:p answer))))))

(defun page-banner (title breadcrumbs)
  "Generates a simple, center-aligned title and breadcrumb for subpages."
  (with-html
    (:div.py-5.bg-light.mb-5
     (:div.container.text-center
      (:h1.fw-bold.text-capitalize.mb-3 title)
      (render-breadcrumbs breadcrumbs)))))

(defun render-breadcrumbs (breadcrumbs)
  "Renders standard Bootstrap breadcrumbs, centered."
  (with-html
    (:nav.d-flex.justify-content-center
     :aria-label "breadcrumb"
     (:ol.breadcrumb.mb-0
      (loop for (label . link) in breadcrumbs
	    do (if link
		   (:li.breadcrumb-item 
		    (:a.text-decoration-none :href link label))
		   (:li.breadcrumb-item.active 
		    :aria-current "page" 
		    label)))))))

(defun service-card (icon title desc)
  (with-html
    (:div.p-4.border.rounded.bg-white.d-flex.flex-column.gap-3
     (:img :src icon
	   :alt "service"
	   :style "width: 4rem;")
     (:div.d-flex.flex-column
      (:h3.mb-2 title)
      (:p.text-secondary desc)))))

(defun render-about-us-section (&key (btn-text "Contact Us Today")
				  (btn-link "/contact-us"))
  "Minimalist, Bootstrap-native About Us component."
  (with-html
    (:div.container.py-5
     (:div.row.g-5.align-items-center
      
      ;; Left: Image with Ukiyo
      (:div.col-lg-5
       :data-cues "fadeIn" :data-duration "900"
       (:div.overflow-hidden.rounded.shadow-lg
        (:img.ukiyo.img-fluid.w-100
         :src "/static/images/hero-afterservice.png"
         :alt "Shinite Cleaning Services")))
      
      ;; Right: Minimal Content
      (:div.col-lg-7
       :data-cues "slideInUp" :data-duration "900"
       (:h2.display-5.fw-bold.mb-4 "We Clean. You Relax.")
       
       (:p.lead.text-secondary.mb-4
        "We transform messy spaces into pristine, healthy environments. Whether it is your home, your office, or a newly constructed property, we handle the dirty work so you can focus on what matters most.")
       
       ;; Simple 3-point list
       (:ul.list-unstyled.d-flex.flex-column.gap-3.mb-5
        (:li.d-flex.align-items-center.gap-3
         (:i.bi.bi-check-circle-fill.text-primary.fs-4)
         (:span.fs-5 "Professional-Grade Equipment"))
        (:li.d-flex.align-items-center.gap-3
         (:i.bi.bi-check-circle-fill.text-primary.fs-4)
         (:span.fs-5 "Reliable, Insured Cleaners"))
        (:li.d-flex.align-items-center.gap-3
         (:i.bi.bi-check-circle-fill.text-primary.fs-4)
         (:span.fs-5 "Flexible, Tailored Scheduling")))
       
       ;; Action Button
       (:a.btn.btn-primary.btn-lg.fw-bold.text-light.px-4
        :href btn-link
        btn-text))))))

(defun render-contact-us-section (&key include-spacer)
  "A simple contact section displaying services and a call-to-order widget."
  (with-html
    (:div.container
     (when include-spacer
       (:div :style "margin-top: 4rem;"))
     (:div.row.g-5.align-items-center
      (:div.col-lg-6
       :data-cues "slideInUp" :data-duration "900"
       (:h2.main-title.mb-4 "Ready to Experience the Elite?")
       (:p.mb-4.fs-5 "We are here to provide top-tier cleaning tailored to your needs. Get in touch today to schedule any of our specialized services:")
       
       ;; Dynamic list of services
       (:ul.list-unstyled.mb-5.d-flex.flex-column.gap-3
	(loop for s in *services*
	      do (:li.d-flex.align-items-center.gap-3
		  (:div.d-flex.justify-content-center.align-items-center.bg-success.bg-opacity-10.rounded-circle
		   :style "width: 40px; height: 40px;"
		   (:i.bi.bi-check2.text-success.fs-4))
		  (:span.fw-bold.fs-5 (getf s :title)))))
       
       ;; Call Widget
       (:div
	:style "max-width: 400px;"
	(display-call-to-order-widget
	 (utils:config :business-phone) 
	 :msg "Book Your Cleaning Today!")))
      
      (:div.col-lg-6
       (:img.img-fluid.rounded.ukiyo :src "/static/images/hero-countertop.png" :alt "contact-us"))))))

(defun render-marquee (features &key feature-classes del-classes)
  (with-html
    (:div.marquee-wrapper.py-4
     (:div.marquee.speed-300
      (dotimes (i 4)
	(dolist (feature features)
	  (:span
	   :class feature-classes
	   feature)
	  (:span
	   :class del-classes
	   (:i.bi.bi-stars
	    :style "font-size: 3rem;"))))))))

(defun format-phone (phone)
  "Formats a phone number into Canadian standard: +1 (XXX) XXX-XXXX."
  (when (str:non-blank-string-p phone)
    (let ((digits (remove-if-not #'digit-char-p phone)))
      ;; If the number is 11 digits and starts with 1, strip the leading 1
      (when (and (= (length digits) 11) (char= (char digits 0) #\1))
        (setf digits (subseq digits 1)))
      
      ;; If we have exactly 10 digits, format it beautifully
      (if (= (length digits) 10)
          (format nil "+1 (~A) ~A-~A"
                  (subseq digits 0 3)
                  (subseq digits 3 6)
                  (subseq digits 6 10))
          ;; Fallback: if it's an unusual length, just return the original string
          phone))))

(defun display-call-to-order-widget (phone &key (msg "Call Us!"))
  (when (str:non-blank-string-p phone)
    (let* ((clean-phone (str:replace-all " " "" phone))
           (half (floor (length clean-phone) 2))
           (p1 (subseq clean-phone 0 half))
           (p2 (subseq clean-phone half)))
      (with-html
        (:div.card.border-success.bg-success.bg-opacity-10.rounded
         (:div.card-body.d-flex.align-items-center.justify-content-between.p-3
          (:div
           (:h6.mb-1.text-success.fw-bold msg)
           (:small.text-muted "Tap to call us directly."))
          
          (:button.btn.btn-success.btn-lg.rounded-circle.shadow-sm
           :type "button"
           :title "Call to Order"
           :style "width: 3.5rem; height: 3.5rem;"
           :onclick (format nil "window.location.href='tel:' + '~a' + '~a';" p1 p2)
           (:i.bi.bi-telephone-fill.fs-4))))))))
