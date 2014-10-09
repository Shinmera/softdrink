#|
 This file is a part of Softdrink
 (c) 2014 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

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
