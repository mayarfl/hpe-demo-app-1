@echo off
rem This is a custom script written by TeamCity using windows-1252 charset.
@echo off
echo "The current directory is %CD%"
git config --global user.email "evgene.lokshin@microfocus.com"
git config --global user.name "lokshin"

set checkoutDir= C:\TeamCity\buildAgent\work\d512b84dc2f018e1
echo "checkoutDir: %checkoutDir%"
 
echo "===== create a new file and push to git ======"

set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%

set "datetimef=%hour%_%time:~3,2%_%time:~6,2%"  
set filename=MyFile-%BUILD_NUMBER%-%datetimef%.txt
set full_filename=%checkoutDir%\%filename%
echo "%full_filename% was created"

rem cd %checkoutDir%

echo "this is my awesome text file" > %filename%
git add .
echo "git commit -m "Add %filename% to branch Master""
git commit -m "Add %filename% to branch Master"
call git push -u origin master --verbose

echo "remove %filename% from git repo"
git rm %filename%
echo "git commit -m "remove %filename%" --author="_alm_octane_auto <_alm_octane_auto@microfocus.com>""
git commit -m "remove %filename%"
echo "git push origin master"
call git push -u origin master --verbose