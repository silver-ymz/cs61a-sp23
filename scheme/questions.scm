(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (f xs cnt) 
    (if (null? xs) xs
      (cons (list cnt (car xs)) (f (cdr xs) (+ cnt 1)))))
  (f s 0))
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to ORDERED? and return
;; the merged lists.
(define (merge ordered? list1 list2)
  ; BEGIN PROBLEM 16
  (cond ((null? list1) list2)
        ((null? list2) list1)
        ((ordered? (car list1) (car list2)) (cons (car list1) (merge ordered? (cdr list1) list2)))
        (else                               (cons (car list2) (merge ordered? list1 (cdr list2))))))
  ; END PROBLEM 16

;; Optional Problem

;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN OPTIONAL PROBLEM
         expr
         ; END OPTIONAL PROBLEM
         )
        ((quoted? expr)
         ; BEGIN OPTIONAL PROBLEM
         expr
         ; END OPTIONAL PROBLEM
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM
           (append (list form params) (map let-to-lambda body))
           ; END OPTIONAL PROBLEM
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM
           (cons (append (list 'lambda (map car values)) (map let-to-lambda body)) 
                 (map let-to-lambda (map cadr values)))
           ; END OPTIONAL PROBLEM
           ))
        (else
         ; BEGIN OPTIONAL PROBLEM
         (map let-to-lambda expr)
         ; END OPTIONAL PROBLEM
         )))

; Some utility functions that you may find useful to implement for let-to-lambda

(define (zip pairs)
  (list (map car pairs) (map cadr pair)))

(define let-to-lambda-code
 '(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN OPTIONAL PROBLEM
         expr
         ; END OPTIONAL PROBLEM
         )
        ((quoted? expr)
         ; BEGIN OPTIONAL PROBLEM
         expr
         ; END OPTIONAL PROBLEM
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM
           (append (list form params) (map let-to-lambda body))
           ; END OPTIONAL PROBLEM
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM
           (cons (append (list 'lambda (map car values)) (map let-to-lambda body)) 
                 (map let-to-lambda (map cadr values)))
           ; END OPTIONAL PROBLEM
           ))
        (else
         ; BEGIN OPTIONAL PROBLEM
         (map let-to-lambda expr)
         ; END OPTIONAL PROBLEM
         ))))

(define let-to-lambda-without-let
 (let-to-lambda let-to-lambda-code))

(define (let-to-lambda-without-let-code expr) 
  (cond ((atom? expr) expr) 
        ((quoted? expr) expr) 
        ((or (lambda? expr) (define? expr))
          (
            (lambda (form params body) (append (list form params) (map let-to-lambda body))) 
            (car expr) (cadr expr) (cddr expr))) 
        ((let? expr) 
          (
            (lambda (values body) 
              (cons 
                (append (list (quote lambda) (map car values)) (map let-to-lambda body)) 
                (map let-to-lambda (map cadr values)))) 
            (cadr expr) (cddr expr)))
        (else (map let-to-lambda expr))))