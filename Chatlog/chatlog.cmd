@echo off
mode con: cols=80 lines=60
title Chat code 
::-------------------------------------
::Le code dessous est pour se connecter
::-------------------------------------
:login 
mode con: cols=60 lines=60
cls 
echo ---------------------
echo Connectez vous au Chat code
echo .
echo .
echo .
echo Veuillez entrez votre pseudo et pressez la touche entree
echo [si vous n'avez pas encore de compte tapez 1]
echo .
set /p pseudo=Pseudo : 
::Verifiez si la variable correspond à 1
if %pseudo%==1 goto creer_un_compte
cls
echo ---------------------
echo Connectez vous au Chat code
echo .
echo .
echo .
echo Veuillez entrez votre mot de passe et pressez la touche entree
echo .
set /p motdepasse=Mot de passe : 
if exist ".\utilisateurs\%pseudo%.dll" goto mdp_verifié
::If the username does not exist, we will now display
::Incorrect Credentials Message and return to login
:informations_incorrectes
cls 
echo Desole mais il semblerait qu'une ou plusieurs des informations soient invalide
timeout /t 3 >nul
goto login
::If the username did exist, we will now check to see if the password matches.
:mdp_verifié
::First, we need to get the password from the file and set it as a variable.
set /p password_file=<".\utilisateurs\%pseudo%.dll"
::Now, Compare the two
if %password_file%==%motdepasse% goto informations_correctes

::if they do not match, go again to incorrect credentials
goto informations_incorrectes

:creer_un_compte
::Here we create an account. We need to ask for a username and password.
cls
echo _____________________
echo Creer un compte
echo ---------------------
echo.
echo.
echo Veuillez entrer vos informations
echo.
set /p nouvel_utilisateur=Pseudo :

::Clear the screen, re-draw and ask for password
cls
echo _____________________
echo Creer un compte
echo ---------------------
echo.
echo.
echo Veuillez entrer vos informations
echo.
set /p nouveau_mdp=Mot de passe :

::Now that we have the information, we need to 
::write it to the account file. We use the .dll extention
echo %nouveau_mdp% >".\utilisateurs\%nouvel_utilisateur%.dll"

::now we confirm creation and go home
echo.
echo Votre compte a bien ete cree !
timeout /t 2 >nul
goto login



:informations_correctes
::If credentials were correct, start up the message viewer and begin asking for input
start cmd /c ".\Message_Displayer.cmd"
mode con: cols=60 lines=42
title Connecte sous %pseudo%
echo. >>.\chat.txt
echo %pseudo% a rejoins le salon >>chat.txt
echo. >>.\chat.txt


:read_messages

cls
mode con: cols=54 lines=4
echo -----------------------------
echo Pour quitter veuillez taper 2
echo -----------------------------
set /p input=Message :
::if input is nothing, go back
if "%input%"=="" goto read_messages
if "%input%"=="2" echo %pseudo% a quitte le chat >>chat.txt
echo. >>.\chat.txt
if "%input%"=="2" exit
::If input is exit, exit the program.


::Input message into chat file
echo %pseudo%: %input% >>chat.txt
echo. >>.\chat.txt
::reset the input to prevent spam
set input=
goto read_messages

