@echo off

set bitness=0
set bitness_nr=-1
set bitness_list[0]=x64
set bitness_list[1]=x86
set pc_name=""

::(for %%a in (%list%) do (
::   echo %%a
::))
::setlocal enableDelayedExpansion
::   echo link's bitness will be !bitness_list[%%bitness_nr]! 
::endlocal

:select_bitness

if %bitness_nr% geq 0 if %bitness_nr% leq 1 goto give_name
set /p bitness_nr=What is your TemViewer's bitness? (0 = x64, 1 = x86)
goto select_bitness

:give_name

set /p pc_name=PC name?
echo %pc_name%

:create_script

call echo link's bitness will be %%bitness_list[%bitness_nr%]%% 

set tv_folder = ""
IF %bitness_nr%==1 (
    set tv_folder = " (x86)"
    echo %tv_folder%
    echo %pc_name%
    )
echo %tv_folder%
echo %pc_name%


set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\TeamViewer %pc_name%.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Program Files\TeamViewer%tv_folder%\TeamViewer.exe" >> %SCRIPT%
echo oLink.Arguments = "-h ServerNameOrIP -a ifix" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%

pause