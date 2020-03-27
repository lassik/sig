(import (scheme base))

(define lf #x0A)
(define cr #x0D)

(define (one->one old new)
  (let ((byte (read-u8)))
    (unless (eof-object? byte)
      (write-u8 (if (= old byte) new byte))
      (one->one old new))))

(define (one->crlf old)
  (let ((byte (read-u8)))
    (unless (eof-object? byte)
      (cond ((= old byte)
             (write-u8 cr)
             (write-u8 lf))
            (else
             (write-u8 byte)))
      (one->crlf old))))

(define (crlf->one new)
  (let ((byte (read-u8)))
    (unless (eof-object? byte)
      (cond ((and (= cr byte) (equal? lf (peek-u8)))
             (read-u8)
             (write-u8 new))
            (else
             (write-u8 byte)))
      (crlf->one new))))

(define (cr->lf) (one->one cr lf))
(define (lf->cr) (one->one lf cr))
(define (cr->crlf) (one->crlf cr))
(define (lf->crlf) (one->crlf lf))
(define (crlf->cr) (crlf->one cr))
(define (crlf->lf) (crlf->one lf))

(define conversions
  (list cr->lf
        lf->cr
        cr->crlf
        lf->crlf
        crlf->cr
        crlf->lf))

(define (try-sequence-1 conversion bv)
  (parameterize ((current-input-port (open-input-bytevector bv))
                 (current-output-port (open-output-bytevector)))
    (conversion)
    (get-output-bytevector (current-output-port))))

(define (try-sequence bv)
  (for-each (lambda (conversion)
              (when (equal? bv (try-sequence-1 conversion bv))
                (error "Conversion not detected:" conversion bv)))
            conversions))

(try-sequence (bytevector cr lf))
