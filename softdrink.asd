(asdf:defsystem softdrink
  :name "Softdrink"
  :version "0.1.0"
  :license "zlib"
  :author "Yukari Hafner <shinmera@tymoon.eu>"
  :maintainer "Yukari Hafner <shinmera@tymoon.eu>"
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
