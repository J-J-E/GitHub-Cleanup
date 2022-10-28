# This has to be run from master
git switch main

# Update our list of remotes
git fetch
git remote prune origin

# Remove local fully merged branches
git branch --merged main | grep -v 'main$' | xargs git branch -d

# Show remote fully merged branches
echo "The following remote branches are fully merged and will be removed:"
git branch -r --merged main | sed 's/ *origin\///' | grep -v 'main$'

read -p "Continue (y/n)? "
if [ "$REPLY" == "y" ]
then
   # Remove remote fully merged branches
   git branch -r --merged main | sed 's/ *origin\///' \
             | grep -v 'main$' | xargs -I% git push origin :%
   echo "Done!"
   echo "Obsolete branches are removed"
fi
