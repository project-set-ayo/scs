(in-package :scs.views)


(defmacro with-layout ((&key title) &body body)
  `(with-html-string
     (:doctype)
     (:html
      :lang "zxx"
      (:head
       (:meta :charset "utf-8")
       (:meta
	:name "viewport"
	:content "width=device-width, initial-scale=1, shrink-to-fit=no")
       (:title ,title)
       
       ;; Links Of CSS File
       (:link :rel "stylesheet"
	      :href "https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css")
       (:link :href "https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" 
	      :rel "stylesheet" 
	      :integrity "sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" 
	      :crossorigin "anonymous")

       (:link :rel "stylesheet" :href "/static/css/swiper-bundle.min.css")
       (:link :rel "stylesheet" :href "/static/css/scrollCue.css")
       (:link :rel "stylesheet" :href "/static/css/tabler-icons.min.css")
       (:link :rel "stylesheet" :href "/static/css/main.css"))
      
      (:body
       ,@body
       
       (:button.bg-secondary
	:type "button"
	:id "backtotop" 
	(:i.bi.bi-arrow-up-circle-fill))
       
       ;; JS Files (Only loaded once now!)
       (:script :src "/static/js/bootstrap.bundle.min.js")
       (:script :src "/static/js/swiper-bundle.min.js")
       (:script :src "/static/js/scrollCue.min.js")
       (:script :src "/static/js/fslightbox.js")
       (:script :src "/static/js/ukiyo.min.js")
       (:script :src "/static/js/lenis.js")
       (:script :src "/static/js/custom.js")))))

(defmacro with-page ((&key title) &body body)
  `(with-layout (:title ,title)
     (site-header)
     (offcanvas-menus)

     (:div.mb-5
      :style "margin-top: 5.8rem;"
      ,@body)
     
     (site-footer)))
