(define (ascending? asc-lst) 
  (if (or (null? asc-lst) (null? (cdr asc-lst))) #t
    (and (<= (car asc-lst) (car (cdr asc-lst)))
         (ascending? (cdr asc-lst)))))

(define (my-filter pred s) 
  (if (null? s) nil
    (if (pred (car s))
        (cons (car s) (my-filter pred (cdr s)))
        (my-filter pred (cdr s)))))

(define (interleave lst1 lst2)
  (if (null? lst1) lst2
    (if (null? lst2) lst1 
      (cons (car lst1) (interleave lst2 (cdr lst1))))))

(define (no-repeats lst)
  (if (null? lst) lst
    (cons (car lst) 
      (no-repeats (my-filter (lambda (x) (not (= x (car lst)))) (cdr lst))))))
