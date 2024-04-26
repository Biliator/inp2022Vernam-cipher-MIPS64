; Autor reseni: Valentyn Vorobec xvorob02

; Projekt 2 - INP 2022
; Vernamova sifra na architekture MIPS64

; DATA SEGMENT
                .data
login:          .asciiz "xvorob02"  ; sem doplnte vas login
cipher:         .space  17  ; misto pro zapis sifrovaneho loginu

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize "funkce" print_string)

; CODE SEGMENT
                .text

                ; ZDE NAHRADTE KOD VASIM RESENIM
main:

                ; xvorob02-r7-r23-r16-r9-r0-r4
                daddi   r9, r0, 0
                daddi   r4, r0, 0 
                lb      r16, login(r4)

loop:
                beqz    r9, addTo
                
subTo:
                daddi   r16, r16, -15

                daddi   r23, r0, 96
                dsub    r23, r23, r16
                bgez    r23, shiftEnd
endShiftEnd:
                sb      r16, cipher(r4)
                daddi   r9, r0, 0
                b       continue

addTo:
                daddi   r16, r16, 22
                daddi   r23, r16, -123
                bgez    r23, shiftStart
endShiftStart:
                sb      r16, cipher(r4)
                daddi   r9, r0, 1

continue:      
                daddi   r4, r4, 1
                lb      r16, login(r4)
                daddi   r23, r16, -97
                bgez    r23, loop


                daddi   r23, r0, cipher  
                dadd    r4, r0, r23
                jal     print_string
                syscall 0   ; halt

shiftStart:
                daddi   r23, r23, 1
                daddi   r16, r23, 96
                b       endShiftStart
shiftEnd:       
                daddi   r16, r0, 122
                dsub    r16, r16, r23
                b       endShiftEnd


print_string:   ; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5   ; systemova procedura - vypis retezce na terminal
                jr      r31 ; return - r31 je urcen na return address
