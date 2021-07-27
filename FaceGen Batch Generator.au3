;2255,347

;2266, 579


#include <Constants.au3>

; Script Function:
;   Automatically generates a series of FaceGen images by changing two values(currently Anger and SmileOpen)
;   Functionality may depend on computer. Currently, you put the FG window in very upper left corner, without
;   leaving the screen
HotKeySet("{ESC}", "Terminate") ;Kill program key, Escape by default
Func Terminate()
	Exit
EndFunc   ;==>Terminate

Global Const $pi = 3.141592653589793

;User editable variables
Global $numAngles = 364 ;Full range ???
Global $skip = 45 ;Number of images to jump
Global $x1 = 885, $y1 = 131, $x2 = 882, $y2 = 369, $x3 = 500, $y3 = 690 ;Set x and y coordinates. Change only if they don't hit the right points.
Global $intensity = 0.5 ;Default, is editable while running below
Global $intensityRange[51] ;Change to 101/51 if needed
Global $intensityAngry[8] ;8 Cardinal directions
Global $intensityHappy[8] ;8 Cardinal directions
Global $mode = "Intensity" ;Use "Intensity" or "Angle" the name you pick is what you're generating (e.g. Angle = 0-359 @ fixed intensity
$mode = "Angle"

;Don't change unless necessary (maybe if it `crashes due to remainders?)
Global $angle[$numAngles / $skip] ;Declare one bigger?
Global $angry[$numAngles / $skip]
Global $happy[$numAngles / $skip]
Global $xCoor = 0.5, $yCoor = 0.5

Global $tester = UBound($angle) ;Just a chosen angle for test

if $mode = "Intensity" Then
	for $i = 0 to UBound($intensityRange) - 1 ;Fill intensities 0 - 100 (101 of them) into 0-100
		$intensityRange[$i] = $i / 100
	  Next
	  ;MsgBox($MB_SYSTEMMODAL,"Warning",$intensityRange[21])
	for $j = 0 to 7 ;UBound($intensityAngry) - 1				;Do ~100 for 0deg, then 45, etc.
	   ;If you want only one angle made, constrict range above, e.g. just 90deg = for $j = 2 to 2
		for $i = 0 to UBound($intensityRange) - 1
			$xCoor = Round($intensityRange[$i] * (Cos(($j * 45) * $pi / 180)), 2) ;Round($intensityRange[$i]*(Cos(($j * 45)*$pi/180)),2)			;Not Scaled Yet
			$yCoor = Round($intensityRange[$i] * (Sin(($j * 45) * $pi / 180)), 2) ;Round($intensityRange[$i]*(Sin(($j * 45)*$pi/180)),2)
			;ConsoleWrite("i = " & $i & ", j = " & $j & " IR = " & $intensityRange[$i] &" x = " & $xCoor & ", y = " & $yCoor & @CRLF)

			;Sleep(10000)

			;;;;;;;for i =
			;for $j = 0 to 5 ;UBound($intensityRange) - 1

			;$xCoor = $intensityRange * $intensityAngry[$i]
			;$yCoor = $intensityRange * $intensityHappy[$i]
			MouseMove($x1, $y1)
			MouseClick("primary")
			MouseClick("primary")
			Sleep(250)
			;Send($intensityAngry[$i] & "{ENTER}")
			;Send($intensityRange[$i] & "{ENTER}")
			Send($xCoor)

			MouseMove($x2, $y2)
			MouseClick("primary")
			MouseClick("primary")
			Sleep(250)
			;Send($intensityHappy[$i] & "{ENTER}")
			;Send($intensityRange[$i] & "{ENTER}")
			Send($yCoor)

			Send("!fi")
			Sleep(250)
			;Send("F:\Backup\Diss\HA v Intensity\" & $j * 45 & "\" & $i)
			Send("C:\Users\seano\Desktop\output\" & $j * 45 & "\" & $i)
			Sleep(750)
			Send("{ENTER}")

			MouseMove($x3, $y3)
			Sleep(500)
			MouseClick("primary")
			Sleep(500)
		Next

	Next

ElseIf $mode = "Angle" Then
	MsgBox($MB_SYSTEMMODAL, "Warning", "This program requires FaceGen to be open and placed in the upper left of the left monitor. It may not work if it is moved. While it is running, do not touch the computer! Escape Key to end it.")
	$intensity = InputBox("Intensity", "Insert the requested intensity, 0 to 1", 1)
	$intensity = Round($intensity, 2)

	for $i = 1 to UBound($angle) - 2
		$angle[$i] = $i * $skip - 1 ;index 20 = 21st item = 40-1 = 39
		$angry[$i] = Round($intensity * Cos($angle[$i] * $pi / 180), 2)
		$happy[$i] = Round($intensity * Sin($angle[$i] * $pi / 180), 2)
	Next

;~ $angle[UBound($angle)-1] = $angle[UBound($angle)-2]+1			;overwrite the old ones because they aren't in steps of 2
;~ $angry[UBound($angle)-1] = $intensity * Cos($angle[UBound($angle)-1]*$pi/180)
;~ $happy[UBound($angle)-1] = $intensity * Sin($angle[UBound($angle)-1]*$pi/180)

	$angle[0] = $angle[1] - 1 ;Doesn't work?
	$angry[0] = Round($intensity * Cos($angle[0] * $pi / 180), 2)
	$happy[0] = Round($intensity * Sin($angle[0] * $pi / 180), 2)

;~ MsgBox($MB_SYSTEMMODAL,"Title", $angle[46])

;~ MsgBox($MB_SYSTEMMODAL,"Title","i = " & $tester & "; Angle = " & $angle[$tester] & _
;~ "; Angry = " & $angry[$tester] & _
;~ "; Happy = " & $happy[$tester])

;~ ;MsgBox($MB_SYSTEMMODAL,"Title",Round(Cos($angle[17]*$pi/180),2))
;~ ;Round(Cos($angle[5]*$pi/180)),2) ;$(cos(0*$pi/180)))


	Global $output = True
	if $output = True Then
		;MsgBox($MB_SYSTEMMODAL,"Title","Pause")
		for $i = 1 to UBound($angle) - 2
			;MouseMove(885,131)
			MouseMove($x1, $y1)
			MouseClick("primary")
			MouseClick("primary")
			Sleep(250)
			Send($angry[$i] & "{ENTER}")

			;MouseMove(882,369)
			MouseMove($x2, $y2)
			MouseClick("primary")
			MouseClick("primary")
			Sleep(250)
			Send($happy[$i] & "{ENTER}")

			Send("!fi")
			Sleep(750)
			Send("C:\Users\seano\Desktop\output\")
			if $angle[$i] < 10 Then
				Send("0" & $angle[$i])
			Else
				Send($angle[$i])
			EndIf

			Send("{ENTER}")

			;MouseMove(500,690)
			MouseMove($x3, $y3)
			Sleep(500)
			MouseClick("primary")
			Sleep(500)
		Next
	EndIf
	;MsgBox($MB_SYSTEMMODAL, "Warning", $i)

Else
	MsgBox("$MB_SYSTEMMODAL", "ERROR", "Invalid Mode.")
EndIf

