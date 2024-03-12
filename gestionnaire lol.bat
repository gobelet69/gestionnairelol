@echo off
@color 9
title Gestionnaire de comptes League of Legends

:start
cls
@echo Sélection de compte
@echo.
type accounts.txt
@echo.

set /p account=Entrez le numéro de compte désiré: 
call :getCredentials %account%
if not defined username (
    @echo Compte invalide, voulez-vous réessayer ? [Y/N]
    set /p yn=
    if /i "%yn%"=="y" goto :start
    if /i "%yn%"=="n" exit
    cls
) else (
    call :copyToClipboard
    @echo.
    @echo Les identifiants ont été copiés dans le presse-papiers.
    timeout /t 3 /nobreak > nul
    goto :end
)

:getCredentials
for /f "tokens=2,3 delims=," %%a in ('findstr /i "^%1," accounts.txt') do (
    set "username=%%a"
    set "password=%%b"
)
exit /b

:copyToClipboard
echo|set /p=%username%|clip
timeout /t 3 /nobreak > nul
echo|set /p=%password%|clip
exit /b

:end
@echo Voulez-vous changer de compte ? [Y/N]
set /p yn=
if /i "%yn%"=="y" goto :start
if /i "%yn%"=="n" exit
cls
exit
