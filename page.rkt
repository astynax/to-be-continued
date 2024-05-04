#lang racket

(require web-server/servlet
         web-server/servlet-env
         web-server/page)

(define (app req)
  (counter 0))

(define (counter value)
  (page 
   (response/xexpr
    `(html
      (body
       (h1 "Counter")
       (h2
        ,(format "~a" value)

        (a ([href ,(embed/url (λ (req)
                               (counter (sub1 value))))])
          "[ - ]")
        
        (a ([href ,(embed/url (λ (req)
                               (counter (add1 value))))])
          "[ + ]")))))))

(serve/servlet app
               #:servlet-path ""
               #:servlet-regexp #rx""
               #:launch-browser? false)
