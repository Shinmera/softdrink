#|
 This file is a part of Softdrink
 (c) 2014 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(asdf:defsystem softdrink
  :name "Softdrink"
  :version "0.1.0"
  :license "Artistic"
  :author "Nicolas Hafner <shinmera@tymoon.eu>"
  :maintainer "Nicolas Hafner <shinmera@tymoon.eu>"
  :description "Tools to inline or extract CSS into/from HTML."
  :homepage "https://Shinmera.github.io/softdrink/"
  :bug-tracker "https://github.com/Shinmera/softdrink/issues"
  :source-control (:git "https://github.com/Shinmera/softdrink.git")
  :serial T
  :components ((:file "package")
               (:file "toolkit")
               (:file "inline")
               (:file "extract"))
  :depends-on (:lquery
               :lass))
