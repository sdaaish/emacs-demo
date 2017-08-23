@echo off

:: Starts emacs with a different config than your normal version.
:: 2017-04-19/SDAA

if [%1]==[] goto usage

if not exist %1 (
   echo File %1 does not exist!
   exit /b 1
)

setlocal
set $file=%~f1
set $dir=%~dp1
echo %$file% %$dir%
emacs --no-init-file --chdir %$dir% --load %$file% %$file%

goto end
:usage
echo "This is an environment to test various emacs options."
echo.
echo "--- Usage: demo.cmd <init-filename> ---"
echo.
echo Directory Contents: 
dir /s /b | findstr /i /l /e "init.el"
exit /b 2

:end
endlocal
