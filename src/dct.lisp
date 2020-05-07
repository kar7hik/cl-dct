;;;; dct.lisp

(in-package #:dct)

(defun dct (input-vector)
  "Discrete Cosine Transformation - II
   Equation from: Discrete-Time Signal Processing - Alan V. Oppenheim"
  (alexandria:coercef input-vector 'vector)
  (let* ((N (length input-vector))
         (dct-result (make-array N :element-type 'single-float :initial-element 0.0)))
    (iter
      (for k :from 0 :below N)
      (let ((X_k 0.0)
            (scale-factor (if (= k 0)
                              (/ 1.0 (sqrt N))
                              (sqrt (/ 2.0 N)))))
        (iter
          (for lower_n :from 0 :below N)
          (for cos-term = (cos (* (/ pi N)
                                  (+ lower_n 0.5)
                                  k)))
          (for x_n in-sequence input-vector)
          (incf X_k (* x_n cos-term scale-factor)))
        (alexandria:coercef X_k 'single-float)
        (setf (aref dct-result k) X_k)))
    dct-result))

;;; Testing:
;; (defparameter *input-vector* (make-array 5 :element-type 'single-float :initial-element 1.0)
;;   "input vector")
;; (dct-ii *input-vector*)


(defun idct (input-vector)
  "Inverse Discrete Cosine Transformation.
  References
  [1]. https://octave.sourceforge.io/signal/function/idct.html
  [2]. Wikipedia, 'Discrete cosine transform',
       http://en.wikipedia.org/wiki/Discrete_cosine_transform
  [3]. Discrete-Time Signal Processing - Alan V. Oppenheim
  "
  (alexandria:coercef input-vector 'vector)
  (let* ((N (length input-vector))
         (idct-result (make-array N :initial-element 0.0 :element-type 'single-float)))
    (iter
      (for lower_n :from 0 :below N)
      (let* ((x_n 0.0))
        (iter
          (for k :from 0 :below N)
          (for X_k in-sequence input-vector)
          (for scale-factor = (if (= k 0)
                                  (/ 1.0 (sqrt N))
                                  (sqrt (/ 2.0 N))))
          (for cos-term = (cos (* (/ pi N)
                                  (+ lower_n 0.5)
                                  k)))
          (incf x_n (* scale-factor X_k cos-term))
          (alexandria:coercef x_n 'single-float))
        (setf (aref idct-result lower_n) x_n)))
    idct-result))



;;; Testing:
;; (defparameter *input-vector* #(-1 -1 -1 -1))

;; (defun compare-dct-idct (input-vector)
;;   (let* ((dct-result (dct-ii input-vector))
;;          (dct-inverse (dct-ii dct-result))
;;          (idct-result (idct dct-result))
;;          (idct-inverse (idct idct-result)))
;;     (format t "~&input-vector: ~A~%" input-vector)
;;     (format t "~&dct-result: ~A~%" dct-result)
;;     (format t "~&dct-inverse: ~A~%" dct-inverse)
;;     (format t "~&idct-result: ~A~%" idct-result)
;;     (format t "~&idct-inverse: ~A~%" idct-inverse)))

;; (compare-dct-idct *input-vector*)
