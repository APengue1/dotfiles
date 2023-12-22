1. config add -p
2. Everything you want to keep that's already there (+) leave it in there.
3. Everything that is incoming that you want to merge (-), replace (-) with space, update the + hunk number only
4. git config --cached
5. config status
6. config restore <file> (this adds the lines you deleted from step 3).
7. config restore --staged <file> (this unstages everything)
8. done! 

