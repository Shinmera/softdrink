(in-package #:org.tymoonnext.softdrink)

(defun to-keyword (thing)
  (intern (string thing) "KEYWORD"))

(defun read-property ()
  (let ((prop (consume-until (make-matcher (is #\:)))))
    (consume)
    (let ((val (with-output-to-string (stream)
                 (loop with in-string = NIL
                       for prev = " " then char
                       for char = (consume)
                       while (and char
                                  (or in-string
                                      (not (char= char #\;))))
                       do (write-char char stream)
                          (when (and (char= char #\")
                                     (char/= prev #\\))
                            (setf in-string (not in-string)))))))
      (cons (string-trim #.(format NIL " ~%") prop)
            (string-trim #.(format NIL " ~%") val)))))

(defun parse-style (style)
  (with-lexer-environment (style)
    (loop while (peek)
          collect (read-property))))
