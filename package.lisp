(defpackage #:softdrink
  (:nicknames #:org.tymoonnext.softdrink)
  (:use #:cl #:plump #:lquery)
  ;; extract.lisp
  (:export
   #:extract-sheet
   #:slurp)
  ;; inline.lisp
  (:export
   #:manipulator
   #:define-manipulator
   #:manipulate
   #:inliner
   #:define-inliner
   #:inline-block
   #:inline-sheet
   #:mix
   #:pour))
