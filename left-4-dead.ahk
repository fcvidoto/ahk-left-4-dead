#SingleInstance Force
#MaxThreads, 999999
#MaxThreadsPerHotkey, 99999
SendMode Input

;------------------------------------------
;Relacionado ao CrossHair 'Mira'
SetWinDelay 0
Coordmode Mouse, Screen

;-------------------------------------------
;Sub Main
WinMove, Left 4 Dead 2,, -3, -26 ; define o tamanho da tela do Left for dead

Restart:
Selecting := False
OldX := -1, OldY := -1

ID1 := Box(2,2,26)
ID2 := Box(3,26,2)

SetTimer Ruler, 10 
Return


;KeyWait, RButton, D
!RButton::             ;using hotkey instead of waiting for a key keeps the right click from calling other behavior during script
SetTimer Ruler, Off


;------------------------------------------
;Relacionado ao Modo de Tiro
v := ComObjCreate("SAPI.SpVoice")
v.Voice := v.GetVoices().Item( 0 ) ; talk voice
v.rate := -1 ; Talk Speed
v.volume := 100 ; Talk volume

styleG:= 0 ; O valor inicial é 0 porque na primeira soma fica no 0

Auto := false
Rap := false	
Bun := false
Sing := false
Bur := false
Nor:= true


Speed := 79
Bullets := 3
AimFast := 12
AimSlow := 3

;Tex0 = Ativado
;v.Speak(Tex0)
Return
;==================================================================================


;------------------------------------------
;Relacionado ao CrossHair
+Escape::
OutOfHere:
ExitApp

Ruler:
MouseGetPos RulerX, RulerY
RulerX := RulerX - 0  ;offset the mouse pointer a bit
RulerY := RulerY - 0

If (OldX <> RulerX)
	OldX := RulerX
If (OldY <> RulerY)
	OldY := RulerY

WinMove ahk_id %ID1%,, %RulerX%, % RulerY-12    ;create crosshair by moving 1/2 length of segment
WinMove ahk_id %ID2%,, % RulerX-12, %RulerY%

;ToolTip (R-click to anchor)
Return

Box(n,wide,high)
{
	Gui %n%:Color, Green                  ; Tiro Normal
	Gui %n%:-Caption +ToolWindow +E0x20 ; No title bar, No taskbar button, Transparent for clicks
	Gui %n%: Show, Center W%wide% H%high%      ; Show it
	WinGet ID, ID, A                    ; ...with HWND/handle ID
	Winset AlwaysOnTop,ON,ahk_id %ID%   ; Keep it always on the top
	WinSet Transparent,255,ahk_id %ID%  ; Opaque
	Return ID
}

;Muda a cor da mira dependendo do tipo de tiro
MudaCorDoCross(cor) {
	
	Gui 2:Color, %cor%                  
	Gui 3:Color, %cor%                  
	
}


;==============================================================================
;------------------------------------------
~LButton::
;Rapid() ; Rapid fire
;Recoil() ; No Recoil
SingleShot() ; Single Shot
BurstFire() ;Burst-Fire
return

^~LButton::
SingleShot() ; Single Shot
BurstFire() ;Burst-Fire
return
;--------------------------------------

/*
	~*space::  ; Bunny Hopping
	Bunny()
	return
*/



; Modo de tiro
CapsLock::
ModoDeTiro()
return


; Modo de tiro
^CapsLock::
ModoDeTiro()
return


;Define o modo de etiro do playa
ModoDeTiro() {
	
	Global styleG
	Global Sing
	Global Bur
	Global Nor
	
	styleG := styleG + 1
	if (styleG > 2) {
		styleG:= 0
		
	} else if (styleG = 1) {
		styleG:= 2		
	}
	
	;Se o tiro unico estiver habilitado
	if (styleG = 0) {
		;v.Speak("Normal")
		Sing:= false
		Bur:= false
		Nor:= false
		
		MudaCorDoCross("Green") ; A mira se torna vermelha
	}
	;Tiro unico
	else if (styleG = 1) {
		;v.Speak("Tiro")
		Sing:= true
		Bur:= false
		Nor:= false
		
		MudaCorDoCross("Red") ; A mira se torna vermelha
		
		;Se for burst-fire
	} else if (styleG = 2) {  
		;v.Speak("Burst")
		Sing:= false
		Bur:= true
		Nor:= false
		
		MudaCorDoCross("Blue") ; A mira se torna vermelha
	} 
}

/*
	CapsLock::
	Auto := ! Auto ; No Recoil
	Tex2 := "Recoil" ((Auto) ? ("On") : ("Off"))
	v.Speak(Tex2)
	return
*/

/*
	MButton::
	Rap := ! Rap ; Rapid Fire
	Tex3 := "RapidFire" ((Rap) ? ("On") : ("Off"))
	v.Speak(Tex3)
	return
*/



;------------------------------------------------------
;Velocidade do tiro
NumpadAdd::  ; Adds Speed to Burst
Speed += 5
return

NumpadSub:: ; Remove/Minus speed to Burst
Speed -= 5
return

;Sub-machines em geral
Numpad1::
Speed:= 0
Bullets:= 4
return

;M16 
Numpad2::
Speed:= 75
Bullets:= 3
return

;AK-47 
Numpad3::
Speed:= 80
Bullets:= 2
return
;------------------------------------------------------
;Adiciona balas a arma
PGUP:: ; Adds bullets to Burst
Bullets += 1
return

PGDN:: ; Remove/Minus bullets to Burst
Bullets -= 1
return
;------------------------------------------------------

Home:: ; Resets Burst
Bullets = 2
Speed = 200
return


/*
	UP:: ; Suspend/Pause
	Suspend, Toggle
	Tex7  := "Suspended " ((Suspend) ? ("On") : ("Off"))
	v.Speak(Tex7)
	return
	
	Down:: ; Mute Voice
	Voi = Muted
	v.Speak(Voi)
	v.volume := 0 ; talk volume
	return
*/

/*
	Ctrl & Esc:: ; Exit Program
	Tex8 := Program Termenated
	v.Speak(Tex8)
	ExitApp
	return
*/

/*
	
	Ctrl & Space:: ; Bunny Hopping
	Bun := ! Bun
	Tex9 := "Bunny " ((Bun) ? ("On") : ("Off"))
	v.Speak(Tex9)
	return
*/

/*
	*LAlt:: ; Steady Hand
	DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, AimSlow, UInt, 0)
	Loop
	{
		Sleep, 10
		GetKeyState, state, LAlt, P
		if state = U
			break
	}
	DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, UInt, AimFast, UInt, 0)
	return
*/


/*
	Recoil() ;Recoil
	{
		Global Auto
		IF Auto
		{
			Loop
			{
				IF GetKeyState("LButton", "P")
				{
					MouseXY(0,3)
					sleep 65
				}
				else
					break
			}
		}
	}
	return
*/

/*
	mouseXY(x,y)  ;Recoil
	{
		DllCall("mouse_event",uint,1,int,x,int,y,uint,0,int,0)
	}
	return
*/




/*
	Shift & LButton:: ; Burst fire
	{
		Loop, %Bullets%
		{
			sendinput, {LButton}
			sleep, %Speed%
		}
		keywait, LButton
	}
	return
*/


/*
	Ctrl & LButton:: ; One Shoot
	{
		Send {LButton} 
		KeyWait LButton
	}
	return
*/

;Habilita os tiros de single
SingleShot() {
	
	Global Sing
	if Sing
	{
		Send {LButton} 
		KeyWait LButton
	}
	
}

;Habilita os tiros de burst
BurstFire() {	
	
	Global Bur
	Global Speed
	Global Bullets
	
	if Bur 
	{
		Loop, %Bullets%
		{
			sendinput, {LButton}
			sleep, %Speed%
		}
		keywait, LButton		
		
	}
}


/*
	Rapid() ; RapidFire
	{
		Global Rap
		IF Rap
		{
			Loop
			{
				IF GetKeyState("LButton", "P")
				{
					sendinput, {LButton}
				}
				else
					break
			}
		}
	}
	return
*/

/*
	Bunny()  ; Bunny
	{
		Global Bun
		IF Bun
			Loop
			{
				GetKeyState,state,space,P
				IF state = U
					break
				
				Send,{space}
				Sleep,20
				
			}
	}
	return
*/