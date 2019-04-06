:: These commands will add a persistent setting in windows's registry 
:: to force constant process priority for a specified executable (name related) 
:: (aka high priority for NAME.EXE)

::===================================================================

::Prework Begin

@echo off

set /a EXIT=0
set EXPECT=.exe
set DIRPATH=%~dp0
IF EXIST (prio.reg) (
    del (prio.reg)
)
copy /Y nul prio.reg
cls
setlocal
echo MIT License
echo Copyright (c) 2019 Maxime Ghazarian
echo.

::Prework End

::===================================================================

::Hello message Begin

echo Please enter a proccess name with its extension (eg. game.exe)
echo.

::Hello message End

::===================================================================

::User entry Begin

set /P EXENAME=user entry:
echo.

::User entry End

::===================================================================

::Entry check Begin

call :strLen ENTRYLEN EXENAME
if %ENTRYLEN% LEQ 4 (
	set EXIT=2
	goto :halt
)

::Entry check End

::===================================================================

::Extension check Begin

set EXTENSION=%EXENAME:~-4%
if %EXTENSION% NEQ %EXPECT% (
	set EXIT=3
	goto :halt
)

::Extension check End

::===================================================================

::Confirmation Begin

choice /M "Is %EXENAME% ok " /c YN
echo.

::Confirmation End

::===================================================================

::Processing Begin

echo Windows Registry Editor Version 5.00>> prio.reg
echo.>> prio.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%EXENAME%\PerfOptions]>> prio.reg
echo "CpuPriorityClass"=dword:00000003>> prio.reg
REGEDIT.EXE  /S  "%~dp0\prio.reg"

::Processing End

::===================================================================

::Process stop Begin

:halt
if errorlevel 255 (
  echo Error.
) else if %EXIT% EQU 2 (
  echo Invalid entry.
) else if %EXIT% EQU 3 (
  echo Invalid file extension.
) else if errorlevel 2 (
  echo Aborted.
)
IF EXIST "%~dp0\prio.reg" (
    del "%~dp0\prio.reg"
)
echo.
echo Done.
echo.
pause
goto :eof

::Process stop End

::===================================================================

::Includes Begin

:strlen <resultVar> <stringVar>
(   
    setlocal EnableDelayedExpansion
    set "s=!%~2!#"
    set "len=0"
    for %%P in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
        if "!s:~%%P,1!" NEQ "" ( 
            set /a "len+=%%P"
            set "s=!s:~%%P!"
        )
    )
)
( 
    endlocal
    set "%~1=%len%"
    exit /b
)

::Includes End
