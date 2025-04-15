@echo off
echo Setting up project environment...

:: Check for Node.js installation
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Node.js is not installed! Please install Node.js 22 from https://nodejs.org/
    exit /b 1
)

:: Check Node.js version
node -v | findstr /C:"v22" >nul
if %ERRORLEVEL% NEQ 0 (
    echo Warning: This project is designed for Node.js 22
    echo Current version:
    node -v
    echo We recommend using Node.js 22 for this project
    timeout /t 3 >nul
)

:: Check if pnpm is already installed
where pnpm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo pnpm is not installed. Attempting to install...
    
    :: Try enabling Corepack
    echo Enabling Corepack for pnpm...
    corepack enable >nul 2>nul
    if %ERRORLEVEL% NEQ 0 (
        echo Error enabling Corepack. You might need admin privileges.
        echo Try running one of these commands from an Administrator Command Prompt:
        echo 1. corepack enable
        echo 2. npm install -g pnpm@10.1.0
        
        set /p CONTINUE=Do you want to continue setup without installing pnpm? (y/n): 
        if /i not "%CONTINUE%"=="y" (
            echo Setup aborted. Please install pnpm and try again.
            exit /b 1
        )
    )
)

:: Check again if pnpm is now available
where pnpm >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    :: Install dependencies
    echo Installing dependencies...
    pnpm install
) else (
    echo pnpm is not available. You'll need to manually install dependencies with:
    echo 1. Install pnpm with: corepack enable OR npm install -g pnpm@10.1.0 (as Administrator)
    echo 2. Run: pnpm install
)

echo Setup complete!
echo Once pnpm is installed and dependencies are installed, run "pnpm dev" to start the development server.