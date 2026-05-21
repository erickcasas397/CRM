@echo off
title INICIANDO AGENDA DE CLIENTES - INFOXPERT
color 0A

set "RAIZ=%~dp0"
set "RAIZ=%RAIZ:~0,-1%"

echo ====================================================
echo             INICIANDO AGENDA DE CLIENTES
echo                     INFOXPERT
echo ====================================================
echo.

:: [1/4] Limpiando procesos previos de Node...
echo [1/4] Limpiando procesos previos de Node...
taskkill /f /im node.exe >nul 2>&1
echo [OK] Puerto despejado.
echo.

:: [2/4] Verificando entorno portable en la subcarpeta...
echo [2/4] Verificando entorno portable...
if not exist "%RAIZ%\agenda-clientes\node-portable\node.exe" (
    color 0C
    echo [ERROR] No se encontro 'node.exe' en la ruta:
    echo "%RAIZ%\agenda-clientes\node-portable\node.exe"
    pause
    exit
)
echo [OK] Entorno listo en 'agenda-clientes\node-portable'.
echo.

:: [3/4] Lanzando el servidor de la Agenda...
echo [3/4] Lanzando servidor local...

:: Guardamos las rutas completas sin usar puntos hacia atras
set "NODE_BIN=%RAIZ%\agenda-clientes\node-portable\node.exe"
set "SERVER_ENTRY=%RAIZ%\agenda-clientes\dist\server\entry.mjs"

:: Nos posicionamos en la raiz del subproyecto para que Astro encuentre bien 'data/clientes.json'
cd /d "%RAIZ%\agenda-clientes"

:: Arrancamos el proceso limpio
start "" /B "%NODE_BIN%" "%SERVER_ENTRY%"
echo [OK] Servidor corriendo en segundo plano.
echo.

:: [4/4] Abriendo el Navegador...
echo [4/4] Abriendo Agenda en el navegador...
timeout /t 4 >nul
start http://localhost:4321
echo.
echo ====================================================
echo    ¡Listo Erick! Ya puedes usar tu Agenda.
echo ====================================================
timeout /t 3 >nul
exit