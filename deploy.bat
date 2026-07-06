@echo off
:: Force the script to execute in the batch file directory
cd /d "%~dp0"

echo ===================================================
echo   Magic Stone - GitHub Pages Deploy Tool
echo ===================================================
echo.

:: Check if Git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed. Please install Git from https://git-scm.com/
    pause
    exit /b
)

:: Configure user details if missing
git config user.name >nul 2>&1
if %errorlevel% equ 0 goto git_user_ok

echo [INFO] Git user details are missing on this system.
set /p git_user="Enter your GitHub username: "
set /p git_email="Enter your GitHub email: "
if not "%git_user%"=="" (
    git config --global user.name "%git_user%"
) else (
    git config --global user.name "MagicStoneUser"
)
if not "%git_email%"=="" (
    git config --global user.email "%git_email%"
) else (
    git config --global user.email "user@magicstone.com"
)

:git_user_ok

:: Initialize local Git repository if needed
if not exist .git (
    echo Initializing local Git repository...
    git init
    git branch -M main
)

:: Set remote origin url if missing (avoiding parenthesis for expansion reliability)
git remote get-url origin >nul 2>&1
if %errorlevel% equ 0 goto remote_ok

echo.
echo Please create a new public repository on GitHub named "magicstone".
echo Do NOT check "Add a README", ".gitignore", or "License" on creation.
echo.

:get_url_loop
set "repo_url="
set /p repo_url="Enter your GitHub HTTPS Repository URL: "
if "%repo_url%"=="" (
    echo [ERROR] Repository URL is required.
    goto get_url_loop
)

git remote add origin %repo_url%

:remote_ok

echo.
echo Adding files to Git staging...
git add .

echo.
echo Committing changes...
git commit -m "Deploy Magic Stone website"

echo.
echo Pushing to GitHub (A browser login window may pop up)...
git push -u origin main --force

if %errorlevel% equ 0 (
    echo.
    echo ===================================================
    echo  [SUCCESS] Website uploaded successfully!
    echo ===================================================
    echo  Please enable GitHub Pages in your browser:
    echo  1. Refresh your GitHub repository page.
    echo  2. Click the [Settings] tab at the top.
    echo  3. Click [Pages] in the left sidebar menu.
    echo  4. Under [Build and deployment] -> [Source], choose "Deploy from a branch".
    echo  5. Under [Branch], select "main", then click [Save].
    echo  6. Wait 1 minute. Your site will be live at:
    echo     https://%git_user%.github.io/magicstone/
    echo ===================================================
) else (
    echo.
    echo [ERROR] Git push failed. Please check your network and credentials.
)

echo.
pause
