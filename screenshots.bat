@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                        ::
::           Android Screenshooter (fb2png)               ::
::          by Kyan He (kyan.ql.he@gmail.com)             ::
::    Maintained by Phil3759 & McKael @ xda-developers    ::
::          Original script for windows (batch)           ::
::              by majdinj @ xda-developers               ::
::          rewritten by carliv @ xda-developers          ::
::                                                        ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd "%~dp0"
IF EXIST "%~dp0\bin" SET PATH=%PATH%;"%~dp0\bin"
chmod -R 755 bin
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Setlocal EnableDelayedExpansion
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
adb start-server >nul
adb get-state >nul
for /f %%a in ('adb get-state') do set state=%%a
if %state%==unknown goto error
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main
cls
adb devices
adb get-state
echo(
echo ****************************************************
echo *                                                  *
ctext "*        {0B}Android Screenshooter {07}(fb2png)            *{\n}"
ctext "*       by {0E}Kyan He {07}(kyan.ql.he@gmail.com)          *{\n}"
ctext "* Maintained by {0E}Phil3759 {07}+ {0E}McKael {07}@ {0E}xda-developers {07}*{\n}"
echo *       Original script for windows (batch)        *
ctext "*           by {0E}majdinj {07}@ {0E}xda-developers {07}           *{\n}"
ctext "*       rewritten by {0B}carliv {07}@ {0E}xda-developers {07}      *{\n}"
echo *                                                  *
echo ****************************************************
echo(
echo  Choose what kind of screenshot you need to take.
echo(
echo ][**********************][
ctext "][ {0B}R.   RECOVERY {07}       ][{\n}"
echo ][**********************][
ctext "][ {0E}A.   ANDROID {07}        ][{\n}"
echo ][**********************][
ctext "][ {0C}E.   EXIT {07}           ][{\n}"
echo ][**********************][
ctext "][ {0B}0.   Reboot recovery {07}][{\n}"
echo ][**********************][
ctext "][ {0E}1.   Reboot android {07} ][{\n}"
echo ][**********************][
echo(
set /p env=Type your option [R,A,E,0,1] then press ENTER: || set env="0"
if /I %env%==R goto recovery
if /I %env%==A goto android
if /I %env%==E goto quit
if %env%==0 goto reboot_recovery
if %env%==1 goto reboot_android
echo(
ctext "{0C}%env% is not a valid option. Please try again! {07}{\n}"
pause
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:reboot_recovery
ctext "{0B}Rebooting to recovery... {07}{\n}"
adb reboot recovery
pause
goto main
:reboot_android
ctext "{0E}Rebooting to android... {07}{\n}"
adb reboot
pause
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:recovery
adb push bin/fb2png /tmp/ >nul
adb shell chmod 755 /tmp/fb2png >nul
:rchoice
cls
adb devices
echo(
echo ****************************************************
echo *                                                  *
ctext "*        {0B}Android Screenshooter {07}(fb2png)            *{\n}"
ctext "*       by {0E}Kyan He {07}(kyan.ql.he@gmail.com)          *{\n}"
ctext "* Maintained by {0E}Phil3759 {07}+ {0E}McKael {07}@ {0E}xda-developers {07}*{\n}"
echo *       Original script for windows (batch)        *
ctext "*           by {0E}majdinj {07}@ {0E}xda-developers {07}           *{\n}"
ctext "*       rewritten by {0B}carliv {07}@ {0E}xda-developers {07}      *{\n}"
echo *                                                  *
echo ****************************************************
echo(
echo ][*************************][
ctext "][         {0B}RECOVERY {07}       ][{\n}"
echo ][*************************][
ctext "][  {0B}S.  Take screenshot {07}   ][{\n}"
echo ][*************************][
ctext "][  {0C}E.  Exit {07}              ][{\n}"
echo ][*************************][
echo ][  Q.  Quit               ][
echo ][*************************][
echo(
set /p renv=Type your option [S,E,Q] then press ENTER: || set renv="0"
if /I %renv%==S goto recovery_screenshot
if /I %renv%==E goto recovery_exit
if /I %renv%==Q goto quit
echo(
ctext "{0C}%renv% is not a valid option. Please try again! {07}{\n}"
pause
goto rchoice
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:recovery_screenshot
for /f "delims=" %%b in ('wmic OS Get localdatetime  ^| find "."') do set "dt=%%b"
set "timestamp=%dt:~8,6%"
set "YYYY=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "rimg=%DD%_%timestamp%"	
set "rfolder=recovery_%YYYY%-%MM%-%DD%"
set "rfile=recscreen_%rimg%.png"
if not exist %rfolder% md %rfolder% >nul
set "rscreenshot=%rfolder%\%rfile%"
echo( 
adb shell "/tmp/fb2png /tmp/fbdump.png > /tmp/info; head -n 20 /tmp/info | tail -n 13; rm -f /tmp/info"
echo(
ctext "{0B}Pulling Screenshot file {07}{\n}"
echo(
adb pull /tmp/fbdump.png %rscreenshot%
adb shell rm -f /tmp/fbdump.png >nul
echo(
ctext "Done! {0E}%rfile% {07}saved in {0E}%rfolder% {07}folder.{\n}"
echo(
pause
goto rchoice
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:recovery_exit
adb shell rm -f /tmp/fb2png >nul
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:android
adb shell mkdir -p /sdcard/Screenshots
:achoice
cls
adb devices
echo(
echo ****************************************************
echo *                                                  *
ctext "*        {0B}Android Screenshooter {07}(fb2png)            *{\n}"
ctext "*       by {0E}Kyan He {07}(kyan.ql.he@gmail.com)          *{\n}"
ctext "* Maintained by {0E}Phil3759 {07}+ {0E}McKael {07}@ {0E}xda-developers {07}*{\n}"
echo *       Original script for windows (batch)        *
ctext "*           by {0E}majdinj {07}@ {0E}xda-developers {07}           *{\n}"
ctext "*       rewritten by {0B}carliv {07}@ {0E}xda-developers {07}      *{\n}"
echo *                                                  *
echo ****************************************************
echo(
echo ][*************************][
ctext "][         {0E}ANDROID {07}        ][{\n}"
echo ][*************************][
ctext "][  {0E}S.  Take screenshot {07}   ][{\n}"
echo ][*************************][
ctext "][  {0C}E.  Exit {07}              ][{\n}"
echo ][*************************][
echo ][  Q.  Quit               ][
echo ][*************************][
echo(
set /p aenv=Type your option [S,E,Q] then press ENTER: || set aenv="0"
if /I %aenv%==S goto android_screenshot
if /I %aenv%==E goto android_exit
if /I %aenv%==Q goto quit
echo(
ctext "{0C}%aenv% is not a valid option. Please try again! {07}{\n}"
pause
goto achoice
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:android_screenshot
for /f "delims=" %%d in ('wmic OS Get localdatetime  ^| find "."') do set "dt=%%d"
set "timestamp=%dt:~8,6%"
set "YYYY=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "aimg=%DD%_%timestamp%"	
set "afolder=android_%YYYY%-%MM%-%DD%"
set "afile=andscreen_%aimg%.png"
if not exist %afolder% md %afolder% >nul
set "ascreenshot=%afolder%\%afile%"
echo( 
adb shell "screencap -p /sdcard/Screenshots/screenos.png" >nul
echo(
ctext "{0E}Pulling Screenshot file {07}{\n}"
echo(
adb pull /sdcard/Screenshots/screenos.png %ascreenshot%
adb shell rm -f /sdcard/Screenshots/screenos.png >nul
echo(
ctext "Done! {0E}%afile% {07}saved in {0E}%afolder% {07}folder.{\n}"
echo(
pause
goto achoice
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:android_exit
adb shell rm -rf /sdcard/Screenshots >nul
goto main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:error
echo(
echo(
ctext "{0C}No device connected through ADB! First connect your phone to PC, then run this program again. {07}{\n}"
pause
goto quit
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:quit
adb kill-server >nul
goto end
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
endlocal
exit
