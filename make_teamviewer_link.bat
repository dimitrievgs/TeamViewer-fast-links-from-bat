@echo off
:: for cyrillic paths (encoding CP1251, Windows-1251)
chcp 1251  >nul

set bitness=0
set bitness_nr=-1
set bitness_list[0]=x64
set bitness_list[1]=x86
set pc_name=""

set LF=^


:: 2 empty lines are required after LF to set it

:select_bitness

setlocal EnableDelayedExpansion
if %bitness_nr% geq 0 if %bitness_nr% leq 1 goto give_name
set /p bitness_nr="What is your TemViewer's bitness? (0 = x64, 1 = x86) !LF!"
goto select_bitness

:give_name

set /p pc_name="Remote computer name (for link name)?!LF!"
set /p pc_id="Remote computer id?!LF!"
set /p pc_pass="Remote computer password (in TeamViewer app)?!LF!"

:create_script

call echo link's bitness will be %%bitness_list[%bitness_nr%]%% 

set tv_folder=""
IF %bitness_nr%==1 (
    set tv_folder=" (x86)"
    )

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
:: echo sLinkFile = "%USERPROFILE%\Desktop\TeamViewer %pc_name%.lnk" >> %SCRIPT%
echo sLinkFile = "%cd%\TeamViewer %pc_name%.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
set "exe_path=C:\Program Files\TeamViewer%tv_folder:~1,-1%\TeamViewer.exe"
echo TeamViewer path is set as: "%exe_path%"
echo oLink.TargetPath = "%exe_path%" >> %SCRIPT%
echo oLink.Arguments = "-i %pc_id% --Password %pc_pass%" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%

endlocal

pause