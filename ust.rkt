#lang racket/base

(require racket/list)

;; Sidenote:
;; ust    = Umsatzsteuer = VAT
;; netto  = net value
;; brutto = gross amount (or gross sum)

(define ust-satz-default 19)

(define (calculate-ust-from-netto netto [ust-satz ust-satz-default])
  (* ust-satz (/ netto 100.0)))

(define (calculate-brutto netto [ust-satz ust-satz-default])
  (let ([ust (calculate-ust-from-netto netto ust-satz)])
        (+ netto ust)))

(define (calculate-netto brutto [ust-satz ust-satz-default])
  (* 100 (/ brutto (+ ust-satz 100))))

(define (represents-number? s)
  (if (string->number s) #t #f))

(define (netto? inputs)
  (and (= (length inputs) 1)
       (represents-number? (first inputs))))

(define (custom-netto? inputs)
  (and (= (length inputs) 2)
       (represents-number? (first inputs))
       (represents-number? (second inputs))))

(define (brutto-flag? s)
  (or (string=? "-b" s)
      (string=? "--brutto" s)))

(define (brutto? inputs)
  (and (= (length inputs) 2)
       (brutto-flag? (first inputs))
       (represents-number? (second inputs))))

(define (custom-brutto? inputs)
  (and (= (length inputs) 3)
       (brutto-flag? (first inputs))
       (represents-number? (second inputs))
       (represents-number? (third inputs))))

(define (calculate-netto-ust-brutto inputs)
  (cond [(netto? inputs) (let ([netto (string->number (first inputs))])
                           (list netto
                                 (calculate-ust-from-netto netto)
                                 ust-satz-default
                                 (calculate-brutto netto)))]
        [(custom-netto? inputs) (let ([netto (string->number (first inputs))]
                                      [ust-satz (string->number (last inputs))])
                                  (list netto
                                        (calculate-ust-from-netto netto ust-satz)
                                        ust-satz
                                        (calculate-brutto netto ust-satz)))]
        [(brutto? inputs) (let* ([brutto (string->number (last inputs))]
                                 [netto (calculate-netto brutto)])
                            (list netto
                                  (calculate-ust-from-netto netto)
                                  ust-satz-default
                                  brutto))]
        [(custom-brutto? inputs) (let* ([brutto (string->number (second inputs))]
                                        [ust-satz (string->number (third inputs))]
                                        [netto (calculate-netto brutto ust-satz)])
                                   (list netto
                                         (calculate-ust-from-netto netto)
                                         ust-satz
                                         brutto))]
        [else (list -1 -1 -1 -1)]))

(define (number->currency num)
  (string-append
   (real->decimal-string num 2)
   " EUR"))

(define (print-results results)
  (let ([netto (first results)]
        [ust (second results)]
        [ust-satz (third results)]
        [brutto (fourth results)])
    (printf "Net Value:     ~a\n" (number->currency netto))
    (printf "VAT amount:    ~a\n" (number->currency ust))
    (printf "VAT:           ~a%\n" ust-satz)
    (printf "Gross amount:  ~a\n" (number->currency brutto))))

(define (run args)
  (print-results (calculate-netto-ust-brutto args)))

(run (vector->list (current-command-line-arguments)))

