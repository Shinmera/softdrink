(asdf:defsystem softdrink
  :name "Softdrink"
  :version "0.1.0"
  :license "zlib"
  :author "Yukari Hafner <shinmera@tymoon.eu>"
  :maintainer "Yukari Hafner <shinmera@tymoon.eu>"
  :description "Tools to inline or extract CSS into/from HTML."
  :homepage "https://shinmera.com/docs/softdrink/"
  :bug-tracker "https://shinmera.com/project/softdrink/issues"
  :source-control (:git "https://shinmera.com/project/softdrink.git")
  :serial T
  :components ((:file "package")
               (:file "toolkit")
               (:file "inline")
               (:file "extract"))
  :depends-on (:lquery
               :lass))
