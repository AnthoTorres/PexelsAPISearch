#  PexelsAPISearch bugs and tasks

## Tasks:

1. Setup Git [x]
2. Project hieracy [x]
3. Task list in a file [x]
4. Setup APIServices [x]
5. Start getting data / get images [x]
6. Find and set the proper cell sizes
7. Use sketch to make a simple 1 - 2 page low or high fedility
8. Setup viewcontrollers and storyboard
9. Make model objects for images
10. Polish the app
    - make sure only 30 images show
    - cache images
    - add 2 - 3 unit test
    - add documentation

## Bugs:
- I was trying to get an image at the wrong time, I needed to us the id for a photo to get a photo. [x]
- I was reloading the collectionView data before the array of photos was set. [x]
- The incorrect number of cells are showing up per row

### Misc Notes:
* the photo base url gave an error in the beginning and until i appended the search string i was not able to fetch data
* I learned how to do a dispatch group and notify when its done.
* I had a similar issue with a group project were i needed to set a certain number of cells per row on a collectionView
* Floting search bar concept ref: https://www.youtube.com/watch?v=p8IaS5lmhuM
* Subsequence concept ref: https://www.youtube.com/watch?v=OTHkcf9gSRw
