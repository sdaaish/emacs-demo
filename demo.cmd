@echo off

:: Starts emacs with different config than normal
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
echo "--- Usage: demo.cmd <filename> ---"
echo :
echo Directory Contents: 
dir /s /b | findstr ".el"
exit /b 2

:end
endlocal
