(define-module (smoothxg)
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

(define-public smoothxg
  (let ((version "0.4.0")
        (commit "74c6a52979551e5b60fc9b3b50387ffc87826841")
        (package-revision "6"))
    (package
     (name "smoothxg")
     (version (string-append version "+" (string-take commit 7) "-" package-revision))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/ekg/smoothxg.git")
                    (commit commit)
                    (recursive? #t)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1fhcmk0pvj8p5c2cp2va3lb0a77q7gpp91fw0kfsx50kcskdsyhk"))))
     (build-system cmake-build-system)
     (arguments
      `(#:phases
        (modify-phases
         %standard-phases
         (delete 'check))
        #:make-flags (list "CC=gcc")))
     (native-inputs
      `(("cmake" ,cmake)
        ("python" ,python)
        ("pybind11" ,pybind11)
        ("gcc" ,gcc-10)
        ("zlib" ,zlib)))
     (synopsis "linearize and simplify variation graphs using blocked partial order alignment")
     (description
"Pangenome graphs built from raw sets of alignments may have complex
local structures generated by common patterns of genome
variation. These local nonlinearities can introduce difficulty in
downstream analyses, visualization, and interpretation of variation
graphs.

smoothxg finds blocks of paths that are collinear within a variation
graph. It applies partial order alignment to each block, yielding an
acyclic variation graph. Then, to yield a smoothed graph, it walks
the original paths to lace these subgraphs together. The resulting
graph only contains cyclic or inverting structures larger than the
chosen block size, and is otherwise manifold linear. In addition to
providing a linear structure to the graph, smoothxg can be used to
extract the consensus pangenome graph by applying the heaviest bundle
algorithm to each chain.

To find blocks, smoothxg applies a greedy algorithm that assumes that
the graph nodes are sorted according to their occurence in the graph's
embedded paths. The path-guided stochastic gradient descent based 1D
sort implemented in odgi sort -Y is designed to provide this kind of
sort.")
     (home-page "https://github.com/ekg/smoothxg")
     (license license:expat))))

