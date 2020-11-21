;; init.scm -- default shepherd configuration file.

(define mcron (make <service>
                    #:provides '(mcron)
                    #:start (make-forkexec-constructor
                              '("/home/work/.other-guix-profiles/general-mcron/bin/mcron"))
                    #:stop (make-kill-destructor)))

(define jupyter (make <service>
                    #:provides '(jupyter)
                    #:start (make-forkexec-constructor
                              '("/home/work/.other-guix-profiles/general-development-jupyter/bin/jupyter" "notebook" "/home/work/Documents/jupyter-notebooks")
                              #:log-file "/home/work/.jupyter/jupyter.log")
                    #:stop (make-kill-destructor)))

;; Services known to shepherd:
;; Add new services (defined using 'make <service>') to shepherd here by
;; providing them as arguments to 'register-services'.
(register-services mcron jupyter)

;; Send shepherd into the background
(action 'shepherd 'daemonize)

;; Services to start when shepherd starts:
;; Add the name of each service that should be started to the list
;; below passed to 'for-each'.
(for-each start '(mcron jupyter))
