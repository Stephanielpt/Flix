# Project 2 - Flix

Flix is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).
On github my master branch might be a bit off because I messed with the branch and github, but if it says master branch then it has the right code  :)

Time spent: 23 hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] User sees an error message when there's a networking error.
- [x] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] Customize the selection effect of the cell.
- [x] Customize the navigation bar.
- [x] Customize the UI.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!
- [x] Can be linked to the site for buying movie tickets (even if the title has spaces WOW!!!)
- [x] Can TRY to save movies (but doesn't fully work)
- [x] Release date of movie is displayed
- [x] Can refresh movie in collection format (in addition to the movies in table view format)
- [x] Can go from search page to the detailed movies page
- [x] Can be linked to trailers
- [x] Can see trailers in detailed movies page
- [x] Showed popular movies in collection view instead of only superhero movies


Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I really wanted to make a page for favorite movies (like a "to-see list) - but editing and displaying an array of movies was really hard
2. I think that looking into design is something I definitely want to explore because even when i do customize UI - i feel like i make it look worse than before lol

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/rFfJOgX.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The favorites list was a truly hard challenge that I was only able to get parts and segments of to work.
In addition, I struggled with passing information through segues, but once I had to do it gfor the trailers - I felt like I gained a strong understanding of it.
Finally, learning about the asynchronous aspect of getting data from the API was really interesting!

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [2018] [Stephanie Lampotang]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
