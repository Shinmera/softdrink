#|
 This file is a part of Softdrink
 (c) 2014 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.tymoonnext.softdrink)

(defun find-similar (node)
  (loop for child across (family node)
        thereis (and (not (eql child node))
                     (string-equal (tag-name child) (tag-name node))
                     child)))

(defun unique-descriptor (node)
  (cond ((attribute node "id")
         (format NIL "#~a" (attribute node "id")))
        ((not (find-similar node))
         (tag-name node))
        (T (format NIL "~a:nth-child(~a)"
                   (tag-name node)
                   (1+ (child-position node))))))

(defun selector (child)
  "Returns a string that should (hopefully) uniquely identify the NODE."
  (format NIL "~{~a~^>~}"
          (nreverse
           (loop for node = child
                 then (parent node)
                 until (or (null node)
                           (typep node 'root))
                 collect (unique-descriptor node)))))

(defun extract-sheet (root &key modify)
  "Extract style elements from ROOT into a LASS sheet.

If MODIFY is non-NIL the STYLE attributes are removed.

Returns two values: the LASS sheet and the ROOT."
  (values
   (coerce
    ($ root "[style]"
      (map #'(lambda (node)
               (let ((style (attribute node "style")))
                 (when modify (remove-attribute node "style"))
                 `(:block (,(selector node))
                    ,@(loop for property in (parse-style style)
                            collect `(:property ,(car property) ,(cdr property))))))))
    'list)
   root))

(defun slurp (source &key stream (pretty lass:*pretty*) modify)
  "Slurp all style information from SOURCE into STREAM.

SOURCE --- can be either a NODE or something PLUMP:PARSEable.
STREAM --- Where to output the CSS to. See LASS:WRITE-SHEET
PRETTY --- Whether to prettify CSS or not. See LASS:WRITE-SHEET
MODIFY --- Whether to modify the root or not. See EXTRACT-SHEET

Returns two values: The ourput of WRITE-SHEET and the ROOT."
  (multiple-value-bind (sheet root) (extract-sheet (typecase source
                                                     (node source)
                                                     (T (parse source)))
                                                   :modify modify)
    (values (lass:write-sheet sheet :stream stream :pretty pretty)
            root)))

;; Todo: Find some way to combine/optimise selectors if they use identical attributes.
