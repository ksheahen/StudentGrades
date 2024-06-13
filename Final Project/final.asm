; COSC 2325.004 Final Project (In-Class)
; Author: Kathryn Sheahen
; Date: 5/1/2024

INCLUDE Irvine32.inc

.data
array1 DWORD 100, 100, 100, 100, 90	;step 1: define an array with the following values
avg DWORD ?
sum DWORD ?
gradePrompt BYTE "Grades: ",0
sumPrompt BYTE "Sum: ",0
avgPrompt BYTE "Average: ",0
letterPrompt BYTE "Letter Grade: ",0
spacePrompt BYTE " ",0

.code
main PROC

	mov esi,OFFSET array1	;offset array to esi
	mov ecx,LENGTHOF array1	;length of array

	mov edx,OFFSET gradePrompt
	call WriteString		;"Grades: "

;step 2: loop through values to display in console
L1:
	mov eax,[esi]		;move array value to eax
	call WriteInt		;write each grade from the array in the console
	add esi,4			;move to the next value
	mov edx,OFFSET spacePrompt
	call WriteString	;add a space in between grades for formatting 
	loop L1


	mov esi,OFFSET array1	;offset array to esi
	mov ecx,LENGTHOF array1	;length of array to ecx
	mov eax,0				;reset eax

;step 3: loop through values to add & display in console
L2:						
	add eax,[esi]	;add current array value to eax
	add esi,4		;move to next value in array
	loop L2

	mov sum,eax		;move the sum from eax to sum variable
	call Crlf		;new line
	mov edx,OFFSET sumPrompt
	call WriteString	;"Sum: "
	call WriteInt	;display sum in console
	call Crlf		;new line

;step 4 display average = sum/num of elements
	mov edx,OFFSET avgPrompt
	call WriteString	;"Average: "
	
	mov eax,sum	;move sum to eax
	mov bl,5	;number of grades
	div bl		;divide by number of grades


	call WriteInt	;display average in console	
	call Crlf	;new line
	
	mov edx,OFFSET letterPrompt
	call WriteString	;"Letter Grade: " display grade Letter in console

	pushad			;push all registers
	mov avg,eax		;move eax to avg variable
	call CalcGrade	;call CalcGrade procedure
	call WriteChar	;write letter grade in console
	popad			;pop all registers

main ENDP

;step 5 - create CalcGrade procedure
CalcGrade PROC
	
	.IF (avg >= 90)		;90-100 = A
		mov al,'A'
	.ELSEIF (avg <= 89)	;89-80 = B
		mov al,'B'
	.ELSEIF (avg <= 79)	;79-70 = C
		mov al,'C'
	.ELSEIF (avg <= 69)	;69-60 = D
		mov al,'D'
	.ELSEIF (avg <= 59)	;59-0 = F
		mov al,'F'
	.ENDIF

	ret
CalcGrade ENDP
END main