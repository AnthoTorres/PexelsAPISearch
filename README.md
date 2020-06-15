# PexelsAPISearch
Searchable image browsing app that uses Pexels API.

# Instructions
This is an iOS Project and you will need Xcode to run it. Please download xcode and open the project file and run on a simulator or an iPhone.

#  PexelsAPISearch bugs and tasks

Thanks so much for the oppertunity to do a project! I think Apprentice is such a cool company and I hope you enjoy the app.

## Tasks:

1. Setup Git [x]
2. Project hieracy [x]
3. Task list in a file [x]
4. Setup APIServices [x]
5. Start getting data / get images [x]
6. Find and set the proper cell sizes [x]
7. Use sketch to make a simple 1 - 2 page low or high fedility [x]
8. Setup viewcontrollers and storyboard [x]
9. Make model objects for post [x]
10. Polish the app []
    - make sure only 30 images show [x]
    - cache images [] //  I was unable to get caching working properly but I will do some research so that I can have solid implementation next time.
    - add 2 - 3 unit test [x] // I was having a hard time thinking up unit tests but I have 1 "testGettingImages()"
    - add documentation []

## Bugs:
- I was trying to get an image at the wrong time, I needed to us the id for a photo to get a photo. [x]
- I was reloading the collectionView data before the array of photos was set. [x]
- The incorrect number of cells are showing up per row. [x]
- cell size keeps changing [x] (instead of using size for item, I used collectionViewFlowLayout) [x]
- I get this error when trying to add an post to my postArray (Thread 55: EXC_BAD_ACCESS (code=EXC_I386_GPFLT) [x]  This was in PostModelController and was on line 53 and was solved by making a temp array that was more local. "tempPostArray" I dont completly undersatnd why this was not working but i think it was just really nested...

### Misc Notes:
* the photo base url gave an error in the beginning and until i appended the search string i was not able to fetch data
* I learned how to do a dispatch group and notify when its done.
* I had a similar issue with a group project were i needed to set a certain number of cells per row on a collectionView
* Floting search bar concept ref: https://www.youtube.com/watch?v=p8IaS5lmhuM
* Subsequence concept ref: https://www.youtube.com/watch?v=OTHkcf9gSRw
* I copied how the game i volunteer on does erro messages


