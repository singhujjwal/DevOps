# Squash Commits in a branch before merging it to  master
## Steps
* Created a file squash.md
* Added the file and put multiple commit messages
* Change the git user and email always else it will show your comapny's email 
* in all the push
* At the end of .git/config add the below
[user]
        name = Ujjwal Singh
        email = singhujjwal@gmail.com

Open the git history using gitk or git log and select the commit to squash the commits to that 
suppose there are 

	- commit-1
	- commit-2
	- commit-3
	- commit-4
and you want to squash it to commit to commit-2, copy the SHA1 of the commit 2
you will see something like 

`git rebase -i SHA1 of commit2` or
`git rebase -i HEAD~2` means 2 commits back

pick e1a4b81 2
pick 5aaa804 3
pick 9b50b08 uff


replace `pick` with `fixup` or `suqash` word 
