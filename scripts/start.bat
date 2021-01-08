
@echo on

set BAD_SLASH_SCRIPT_DIR=%~dp0
set SCRIPT_DIR=%BAD_SLASH_SCRIPT_DIR:\=/%
set PROJECT_DIR=%SCRIPT_DIR%..

set PATH=%PATH%;%PROJECT_DIR%/tools/nasm;%PROJECT_DIR%/tools/perl/perl/bin

call "C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Auxiliary/Build/vcvars64.bat"
call "%PROJECT_DIR%/tools/msys/msys.bat"
