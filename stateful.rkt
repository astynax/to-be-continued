#lang racket

(require web-server/servlet
         web-server/servlet-env)

(define (app req)
  (define req-with-name
    (send/suspend
     (λ (url)
       (response/xexpr
        `(html
          (body
           (form ([action ,url])
                 (label
                  "What is your name:"
                  (input ([name "name"])))
                 (input ([type "submit"])))))))))
  
  (define bindings (request-bindings req-with-name))
  (define name (extract-binding/single 'name bindings))
  
  (send/finish
   (response/xexpr
    `(html
      (body
       (h1 "Hello, " ,name "!")
       (a ([href "/"]) "Go back"))))))

(serve/servlet app
               #:servlet-path ""
               #:servlet-regexp #rx""
               #:launch-browser? false)