#!/bin/bash
DATE=`date +%Y-%m-%d`
if [[ "$1" == '' ]]; then comment="Update $DATE"; else comment=$1; fi

echo Pushing NEMS update: $comment
echo ""
read -s -p "Github Password: " password

cd /root/nems/nems-admin
echo ""
pwd
git add *
git commit -am "$comment"
#git push origin master
git push "https://Cat5TV:$password@github.com/Cat5TV/nems-admin.git"

cd /usr/local/share/nems/nems-scripts/
echo ""
pwd
git add *
git commit -am "$comment"
#git push origin master
git push "https://Cat5TV:$password@github.com/Cat5TV/nems-scripts.git"

cd /var/www/html/
echo ""
pwd
git add *
git commit -am "$comment"
#git push origin master
git push "https://Cat5TV:$password@github.com/Cat5TV/nems-www.git"

cd /root/nems/nems-migrator/
echo ""
pwd
git add *
git commit -am "$comment"
#git push origin master
git push "https://Cat5TV:$password@github.com/Cat5TV/nems-migrator.git"

cd /var/www/nconf/
echo ""
pwd
git add *
git commit -am "$comment"
#git push origin develop
git push "https://Cat5TV:$password@github.com/Cat5TV/nconf.git"

if [[ -d /root/nems/nems-tools ]]; then
  cd /root/nems/nems-tools
  echo ""
  pwd
  git add *
  git commit -am "$comment"
  #git push origin master
  git push "https://Cat5TV:$password@github.com/Cat5TV/nems-tools.git"
fi
