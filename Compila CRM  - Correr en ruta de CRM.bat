npm run dev
@echo off
title Servidor CRM - INFOXPERT
cd /d "%~dp0"
echo ==========================================
echo    INICIANDO SERVIDOR PORTABLE CRM
echo ==========================================
echo.
npm run build
pause