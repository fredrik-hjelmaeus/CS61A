
(define (add-interval x y)
  (make-interval (+ (lower-bound x) 
                    (lower-bound y))
                 (+ (upper-bound x) 
                    (upper-bound y))))
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) 
               (lower-bound y)))
        (p2 (* (lower-bound x) 
               (upper-bound y)))
        (p3 (* (upper-bound x) 
               (lower-bound y)))
        (p4 (* (upper-bound x) 
               (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
(define (div-interval x y)
  (mul-interval x 
                (make-interval 
                 (/ 1.0 (upper-bound y)) 
                 (/ 1.0 (lower-bound y)))))

(define (make-interval a b) (cons a b))
(define (upper-bound interval)
    (cdr interval)
)
(define (lower-bound interval)
    (car interval)
)
;testing
(add-interval (make-interval 5 6) (make-interval 2 4)); (7 . 10)
(mul-interval (make-interval 5 6) (make-interval 2 4)); (10. 24)
(div-interval (make-interval 5 6) (make-interval 2 4)); (1.25 . 3.0)



#| Exercise 2.8: Using reasoning analogous to Alyssa’s, describe how the difference of two intervals may be computed. Define a corresponding subtraction procedure, called sub-interval.  |#
(define (sub-interval x y)
    (make-interval (- (lower-bound x) 
                      (lower-bound y)
                   )
                   (- (upper-bound x) 
                      (upper-bound y)
                   )
    )
)

;testing
(sub-interval (make-interval 5 6) (make-interval 2 4)); (3 . 2)






#| Exercise 2.10: Ben Bitdiddle, an expert systems programmer, looks over Alyssa’s shoulder and comments that it is not clear what it means to divide by an interval that spans zero. 
Modify Alyssa’s code to check for this condition and to signal an error if it occurs.  |#

(define (div-interval x y)
  
      (mul-interval x 
        (if (check-negative-num x y)
                (make-interval 
                 (/ 1.0 (upper-bound y)) 
                 (/ 1.0 (lower-bound y))
                )
                #f
        )
      )
)


(define (check-negative-num x y)
    (if (< (or (upper-bound y)) (lower-bound y) 0)
        (error "Interval must be positive values")
        #t
    )
)

(div-interval (make-interval 4 5) (make-interval -2 -4)); error-message
(div-interval (make-interval 4 5) (make-interval 2 4)); (1.0 . 2.5)
(check-negative-num (make-interval 3 4) (make-interval -2 -4)); error-message
(check-negative-num (make-interval 3 4) (make-interval 2 4)); #t
