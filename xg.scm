(define-module (xg)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression))

(define-public xg
  (let ((version "0.1.0")
        (commit "915afe6d012a87557c7b2ce9c436bc0f13ac7990")
        (package-revision "1"))
    (package
     (name "xg")
     (version (string-append version "+" (string-take commit 7) "-" package-revision))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/vgteam/xg.git")
                    (commit commit)
                    (recursive? #t)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0rm3x4dclq7fq1qajy4a8nq028bia2viqylq5kjgnrfjckwwb13r"))))
     (build-system cmake-build-system)
     (arguments
      `(#:phases
        (modify-phases
         %standard-phases
         (delete 'check))
        #:make-flags (list "CC=gcc")))
     (native-inputs
      `(("cmake" ,cmake)
        ("glibc" ,glibc)
        ("gcc" ,gcc-9)
        ("zlib" ,zlib)))
     (synopsis "succinct static genome variation graph index")
     (description
"The XG index is a succinct, static index for genome variation graphs.
This utility reads GFA and writes XG format version of the graph. It
may also be used to annotate the nodes of graphs in GFA with path
positions.")
     (home-page "https://github.com/vgteam/xg")
     (license license:expat))))

