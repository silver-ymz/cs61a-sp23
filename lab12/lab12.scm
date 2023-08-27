(define (substitute s old new)
  (if (null? s) s
    (let ((xs (substitute (cdr s) old new)))
      (if (pair? (car s))
          (cons (substitute (car s) old new) xs)
          (if (equal? (car s) old)
              (cons new xs)
              (cons (car s) xs))))))

; Feel free to use these helper procedures in your solution
(define (map fn s)
  (if (null? s)
      nil
      (cons (fn (car s)) (map fn (cdr s)))))

(define (filter fn s)
  (cond 
    ((null? s)    nil)
    ((fn (car s)) (cons (car s) (filter fn (cdr s))))
    (else         (filter fn (cdr s)))))

(define (count x s) 
  (length (filter (lambda (n) (eq? n x)) s)))

(define (unique s)
  (if (null? s) s
    (cons (car s) 
          (unique (filter (lambda (x) (not (eq? x (car s)))) (cdr s))))))

(define (tally names)
  (map (lambda (name) (list name (count name names))) (unique names)))
