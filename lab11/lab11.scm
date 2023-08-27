; (define (over-or-under num1 num2) 
;   (cond 
;     ((< num1 num2) -1)
;     ((= num1 num2) 0)
;     ((> num1 num2) 1)))

(define (over-or-under num1 num2)
  (if (< num1 num2) -1 (
    if (= num1 num2) 0 1)))

(define (make-adder num) 
  (lambda (inc) (+ num inc)))

(define (composed f g) 
  (lambda (x) (f (g x))))

(define (repeat f n) 
  (lambda (x) (
    if (= n 0) x ((repeat f (- n 1)) (f x)))))

(define (max a b)
  (if (> a b)
      a
      b))

(define (min a b)
  (if (> a b)
      b
      a))

(define (gcd a b)
  (let ((mi (min a b)) (ma (max a b))) 
    (let ((mod (modulo ma mi)))
      (if (zero? mod)
          mi
          (gcd mi mod)))))
