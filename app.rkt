#lang racket

(require web-server/servlet
         web-server/servlet-env)

(define (app req)
  (response/xexpr
   `(html
     (body
      (h1 "Hello World!")))))

(serve/servlet app
               #:servlet-path ""
               #:servlet-regexp #rx""
               #:launch-browser? false)