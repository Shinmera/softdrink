(in-package #:org.tymoonnext.softdrink)

(defvar *manipulators* (make-hash-table))
(defvar *inliners* (make-hash-table))

(defun manipulator (type)
  "Returns a function to use as a manipulator. The TYPE is automatically converted to a keyword.
If no fitting function can be found, a noop-function is returned."
  (or (gethash (to-keyword type) *manipulators*)
      #'(lambda (&rest args) (declare (ignore args)))))

(defun (setf manipulator) (function type)
  "Set a new manipulator function. The TYPE is automatically converted to a keyword."
  (setf (gethash (to-keyword type) *manipulators*)
        function))

(defmacro define-manipulator (name (element &rest args) &body body)
  "Defines a new manipulator.

NAME    --- The manipulator's name, automatically converted to a keyword.
ELEMENT --- Symbol bound to the element to process.
ARGS    --- Lambda-list for the manipulator arguments."
  `(progn (setf (manipulator ,(to-keyword name))
                #'(lambda (,element ,@args)
                    ,@body))
          ,(to-keyword name)))

(defun manipulate (node item)
  "Manipulate the NODE with the given ITEM.
Returns the NODE."
  (apply (manipulator (car item))
         node (cdr item))
  node)

(defun inliner (type)
  "Returns a function to use as an inliner. The TYPE is automatically converted to a keyword.
If no fitting function can be found, a noop-function is returned."
  (or (gethash (to-keyword type) *inliners*)
      #'(lambda (&rest args) (declare (ignore args)))))

(defun (setf inliner) (function type)
  "Set a new inliner function. The TYPE is automatically converted to a keyword."
  (setf (gethash (to-keyword type) *inliners*)
        function))

(defmacro define-inliner (name (root &rest args) &body body)
  "Defines a new inliner.

NAME --- The inliner's name, automatically converted to a keyword.
ROOT --- Symbol bound to the root node to process.
ARGS --- Lambda-list for the manipulator arguments."
  `(progn (setf (inliner ,(to-keyword name))
                #'(lambda (,root ,@args)
                    ,@body))
          ,(to-keyword name)))

(defun inline-block (root block)
  "Inlines the given LASS block into the ROOT node.
Returns the ROOT."
  (apply (inliner (car block))
         root (cdr block))
  root)

(define-manipulator property (element property &rest args)
  ($ element (css property (format NIL "~{~a~^ ~}" args))))

(define-inliner block (root selectors &rest items)
  (loop for selector in (loop for constraint in (rest selectors)
                              collect (with-output-to-string (out)
                                        (lass:write-sheet-object :constraint (rest constraint) out)))
        do (loop for item in items
                 do ($ root (inline selector)
                      (each (lambda (node) (manipulate node item)))))))

(defun inline-sheet (lass-sheet root)
  "Inlines the given LASS-SHEET into the ROOT node.
Returns the ROOT."
  (loop for item in lass-sheet
        do (inline-block root item))
  root)

(defun mix (source &rest lass-sheet)
  "Mixes the LASS-SHEET definition into the SOURCE.
Returns a NODE.

Source can either be a NODE or something PARSEable.

See PLUMP:PARSE, LASS:COMPILE-SHEET"
  (inline-sheet
   (apply #'lass:compile-sheet lass-sheet)
   (typecase source
     (node source)
     (T (parse source)))))

(defun pour (node &optional (stream NIL))
  "Serializes NODE into STREAM.

STREAM can either be an object of type STREAM,
NIL (to string), or T (to *standard-output*).

See PLUMP:SERIALIZE"
  (case stream
    ((nil) (with-output-to-string (stream)
             (serialize node stream)))
    ((T) (serialize node *standard-output*))
    (T (serialize node stream))))
