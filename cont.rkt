#lang racket

(displayln "simple call/cc")

(println
 (call/cc
  (λ (stop)
    (define (go n s)
      (when (> s 100)
        (stop n))
      (go (+ n 1) (* s n)))
    (go 1 1))))


(displayln "capturing")

(define k #f)
(call-with-continuation-prompt
 (λ _
   (+ 1
      (+ 2
         (call-with-composable-continuation
          (λ (cont)
            (set! k cont)
            0))))))
(println (k 10))
(println (k 100))


(displayln "barriers")

(let [(k #f)]
  (call-with-continuation-barrier
   (λ _
     (+ 1
        (call-with-current-continuation
         (λ (v)
           (set! k v)
           1)))))
  (k 10))
