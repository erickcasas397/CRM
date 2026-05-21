
@echo off
cd /d "%~dp0agenda-clientes"

echo [1/2] Compilando...
call npm run build

echo [2/2] Iniciando servidor de previsualizacion...
echo El CRM se abrira en unos segundos...
start http://localhost:4321
call npm run preview