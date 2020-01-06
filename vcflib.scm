(define-module (vcflib)
               #:use-module (guix packages)
               #:use-module (guix git-download)
               #:use-module (guix build-system gnu)
               #:use-module (guix licenses)
               #:use-module (gnu packages base)
               #:use-module (gnu packages gcc)
               #:use-module (gnu packages cmake)
               #:use-module (gnu packages python)
               #:use-module (gnu packages wget)
               #:use-module (gnu packages bash)
               #:use-module (gnu packages compression))

(define-public vcflib
  (let ((version "v1.0.1")
        (commit "9173df9ccff52daa4b3849b0e8d28dd4a7ecb39b")
        (package-revision "0"))
    (package
     (name "vcflib")
     (version (string-append (git-version version "+" commit) "-" package-revision))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/vcflib/vcflib.git")
                    (commit commit)
                    (recursive? #t)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "01zlbs8v1zfm7y66p9yyshaqy5r5vri5xn14il8vwjy1ld8v0z64"))))
     (build-system gnu-build-system)
     (arguments
      `(#:phases
        (modify-phases
         %standard-phases
         ;; Setting the SHELL environment variable is required by SeqLib's configure script
         (add-after 'unpack 'set-shell
                    (lambda _
                      (setenv "CONFIG_SHELL" (which "sh"))
                      #t))
         (delete 'configure)
         (delete 'check)
         (replace 'install
                  (lambda* (#:key outputs #:allow-other-keys)
                           (let ((bin (string-append (assoc-ref outputs "out") "/bin")))
                             (install-file "bin/vcf2fasta" bin)
                             (install-file "bin/wcFst" bin)
                             (install-file "bin/vcfremovenonATGC" bin)
                             (install-file "bin/vcfentropy" bin)
                             (install-file "bin/vcfmultiallelic" bin)
                             (install-file "bin/vcfrandom" bin)
                             (install-file "bin/vcfsamplediff" bin)
                             (install-file "bin/vcfcomplex" bin)
                             (install-file "bin/plotBfst.R" bin)
                             (install-file "bin/vcf_strip_extra_headers" bin)
                             (install-file "bin/vcfgenotypes" bin)
                             (install-file "bin/vcfsamplenames" bin)
                             (install-file "bin/vcfplotaltdiscrepancy.sh" bin)
                             (install-file "bin/vcfprintaltdiscrepancy.r" bin)
                             (install-file "bin/vcfindels" bin)
                             (install-file "bin/vcffirstheader" bin)
                             (install-file "bin/abba-baba" bin)
                             (install-file "bin/sequenceDiversity" bin)
                             (install-file "bin/vcfclassify" bin)
                             (install-file "bin/vcf2tsv" bin)
                             (install-file "bin/dumpContigsFromHeader" bin)
                             (install-file "bin/vcfgeno2haplo" bin)
                             (install-file "bin/vcfregionreduce_uncompressed" bin)
                             (install-file "bin/vcfannotategenotypes" bin)
                             (install-file "bin/vcfqual2info" bin)
                             (install-file "bin/vcfafpath" bin)
                             (install-file "bin/vcfcommonsamples" bin)
                             (install-file "bin/plot_roc.r" bin)
                             (install-file "bin/vcfnulldotslashdot" bin)
                             (install-file "bin/plotPfst.R" bin)
                             (install-file "bin/vcfdistance" bin)
                             (install-file "bin/vcfmultiwayscripts" bin)
                             (install-file "bin/vcfmultiway" bin)
                             (install-file "bin/plotWCfst.R" bin)
                             (install-file "bin/vcfregionreduce_pipe" bin)
                             (install-file "bin/vcfcreatemulti" bin)
                             (install-file "bin/vcf2bed.py" bin)
                             (install-file "bin/vcfplotaltdiscrepancy.r" bin)
                             (install-file "bin/vcfcheck" bin)
                             (install-file "bin/plotHaps" bin)
                             (install-file "bin/vcfindex" bin)
                             (install-file "bin/vcfgeno2alleles" bin)
                             (install-file "bin/vcfstreamsort" bin)
                             (install-file "bin/popStats" bin)
                             (install-file "bin/vcfbiallelic" bin)
                             (install-file "bin/vcfkeepgeno" bin)
                             (install-file "bin/vcfremap" bin)
                             (install-file "bin/normalize-iHS" bin)
                             (install-file "bin/vcf2sqlite.py" bin)
                             (install-file "bin/vcfflatten" bin)
                             (install-file "bin/vcfnoindels" bin)
                             (install-file "bin/vcfregionreduce_and_cut" bin)
                             (install-file "bin/vcffixup" bin)
                             (install-file "bin/vcfclearid" bin)
                             (install-file "bin/vcfrandomsample" bin)
                             (install-file "bin/vcfplottstv.sh" bin)
                             (install-file "bin/bFst" bin)
                             (install-file "bin/vcfqualfilter" bin)
                             (install-file "bin/vcfhetcount" bin)
                             (install-file "bin/plotXPEHH.R" bin)
                             (install-file "bin/meltEHH" bin)
                             (install-file "bin/segmentFst" bin)
                             (install-file "bin/vcfjoincalls" bin)
                             (install-file "bin/plotSmoothed.R" bin)
                             (install-file "bin/vcfgenosamplenames" bin)
                             (install-file "bin/iHS" bin)
                             (install-file "bin/vcfcountalleles" bin)
                             (install-file "bin/vcfallelicprimitives" bin)
                             (install-file "bin/permuteSmooth" bin)
                             (install-file "bin/vcfparsealts" bin)
                             (install-file "bin/bgziptabix" bin)
                             (install-file "bin/segmentIhs" bin)
                             (install-file "bin/vcfcleancomplex" bin)
                             (install-file "bin/vcfleftalign" bin)
                             (install-file "bin/plotHaplotypes.R" bin)
                             (install-file "bin/smoother" bin)
                             (install-file "bin/vcfnobiallelicsnps" bin)
                             (install-file "bin/vcfcat" bin)
                             (install-file "bin/vcfannotate" bin)
                             (install-file "bin/vcfnosnps" bin)
                             (install-file "bin/vcfsnps" bin)
                             (install-file "bin/vcfld" bin)
                             (install-file "bin/vcfremoveaberrantgenotypes" bin)
                             (install-file "bin/vcffilter" bin)
                             (install-file "bin/vcfkeepinfo" bin)
                             (install-file "bin/vcfglxgt" bin)
                             (install-file "bin/vcfevenregions" bin)
                             (install-file "bin/vcflength" bin)
                             (install-file "bin/vcfregionreduce" bin)
                             (install-file "bin/vcfoverlay" bin)
                             (install-file "bin/genotypeSummary" bin)
                             (install-file "bin/vcfhethomratio" bin)
                             (install-file "bin/vcfcombine" bin)
                             (install-file "bin/vcfstats" bin)
                             (install-file "bin/vcfsitesummarize" bin)
                             (install-file "bin/vcfsample2info" bin)
                             (install-file "bin/vcfprintaltdiscrepancy.sh" bin)
                             (install-file "bin/vcfsort" bin)
                             (install-file "bin/pFst" bin)
                             (install-file "bin/vcfprimers" bin)
                             (install-file "bin/vcfgenotypecompare" bin)
                             (install-file "bin/vcfvarstats" bin)
                             (install-file "bin/vcfinfosummarize" bin)
                             (install-file "bin/permuteGPAT++" bin)
                             (install-file "bin/vcfaltcount" bin)
                             (install-file "bin/vcfaddinfo" bin)
                             (install-file "bin/vcfuniq" bin)
                             (install-file "bin/vcfremovesamples" bin)
                             (install-file "bin/vcfinfo2qual" bin)
                             (install-file "bin/vcfintersect" bin)
                             (install-file "bin/plotHapLrt.R" bin)
                             (install-file "bin/vcf2dag" bin)
                             (install-file "bin/vcfunphase" bin)
                             (install-file "bin/vcfplotsitediscrepancy.r" bin)
                             (install-file "bin/vcfgtcompare.sh" bin)
                             (install-file "bin/vcfuniqalleles" bin)
                             (install-file "bin/hapLrt" bin)
                             (install-file "bin/vcfnull2ref" bin)
                             (install-file "bin/vcfbreakmulti" bin)
                             (install-file "bin/vcfnormalizesvs" bin)
                             (install-file "bin/bed2region" bin)
                             (install-file "bin/pVst" bin)
                             (install-file "bin/vcfgenosummarize" bin)
                             (install-file "bin/vcfecho" bin)
                             (install-file "bin/vcfnumalt" bin)
                             (install-file "bin/vcfclearinfo" bin)
                             (install-file "bin/vcfindelproximity" bin)
                             (install-file "bin/vcfglbound" bin)
                             (install-file "bin/vcfkeepsamples" bin)
                             (install-file "bin/vcfroc" bin)))))
        #:make-flags (list "CC=gcc")))
     (native-inputs
      `(("wget" ,wget)
        ("cmake" ,cmake)
        ("zlib" ,zlib)))
     (synopsis "vcflib variant call file (VCF) manipulation and analysis")
     (description
      "vcflib provides methods to manipulate and interpret sequence variation as it can be described by VCF. It is both: an API for parsing and operating on records of genomic variation as it can be described by the VCF format, and a collection of command-line utilities for executing complex manipulations on VCF files.")
     (home-page "https://github.com/vcflib/vcflib")
     (license expat))))

vcflib
