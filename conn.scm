#!/usr/bin/env kawa

(define file-name "/home/mindspice/.scripts/scheme/conn-dict.csv")

(define (csv-to-list file)
    (call-with-input-file file
        (lambda (port)
            (let ((line (read-line port)))
                (if (eof-object? line)
                    '()
                    (string-split line ","))))))

(define (find-path name lst)
    (cond
        ((null? lst) (display "No entry Found \n")) 
        ((string=? name (car lst)) (cadr lst))  
        (else (and (pair? (cdr lst)) (find-path name (cddr lst))))))


(define (add-path key path lst)
    (cons key (cons path lst)))

(define (remove-path key lst)
    (cond
        ((null? lst) '())
        ((string=? key (car lst)) (cddr lst))
        (else (cons (car lst) (remove-path key (cdr lst))))))

(define (list-to-csv lst)
    (string-join lst ","))

(define (write-to-file file lst)
    (call-with-output-file file
        (lambda (port)
            (display (list-to-csv lst) port)
            (newline port))))

(define (main args)
    ;skip first arg as needed from the command line
    (let ((actual-args (cdr args)))
    (cond
        ((null? actual-args) (display "Must provide a key to connect to \"conn <key>\" or call with the arguments \"--add-host <key> <path>\" or \"--remove-host <key>\"\n" ))
        ((string=? (car actual-args) "--add-host")
        (if (>= (length actual-args) 3)
            (let ((updated-list (add-path (cadr actual-args) (caddr actual-args) (remove-path (cadr actual-args) (csv-to-list file-name)))))
                (write-to-file file-name updated-list)
                (display "Host added.\n"))
            (display "Insufficient arguments for --add-host.\n")))
        ((string=? (car actual-args) "--remove-host")
        (if (>= (length actual-args) 2)
            (let ((updated-list (remove-path (cadr actual-args) (csv-to-list file-name))))
                (write-to-file file-name updated-list)
                (display "Host removed.\n"))
            (display "Insufficient arguments for --remove-host.\n")))
        (else
        (let ((result (find-path (car actual-args) (csv-to-list file-name))))
            (if result
                (display result)
                (display "Path not found.\n")))))))

(main (command-line))
