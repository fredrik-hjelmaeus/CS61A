#| 4.Write a predicate ordered? that takes a sentence of numbers as its argument 
     and returns a true value if the numbers are in ascending order, 
     or a false value otherwise. |#

; testsentences
(define sent '(1 2 3 4 5))
(define sent2 '(5 4 3 2 1))
(define sent3 '(1 2 3 2 1))

(define re #t)
(define counter (first sent))
(define (ordered? sent)
     (if (empty? (bf sent))
          re
          (if  (equal? (- (first (bf sent)) (first sent)) 1) (ordered? (bf sent)) #f)))

     


