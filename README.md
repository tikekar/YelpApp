# Project 2 - *Yelp App*

**Yelp app** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: 22 hours spent in total

## User Stories

The following **required** functionality is completed:

- [ ] Search results page
   - [X] Table rows should be dynamic height according to the content height.
   - [X] Custom cells should have the proper Auto Layout constraints.
   - [X] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [ ] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [X] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [X] The filters table should be organized into sections as in the mock.
   - [X] You can use the default UISwitch for on/off states.
   - [X] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [X] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [ ] Search results page
   - [X] Infinite scroll for restaurant results.
   - [X] Implement map view of restaurant results.
- [ ] Filter page
   - [X] iOS 10 does not allow changing the on and off image for UISwitch. Changing it had no effect. So I only changed its background color
   - [X] Distance filter should expand as in the real Yelp app
   - [X] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [X] Implement the restaurant detail page. (Clicking the restaurant cell opens it in the map page)

The following **additional** features are implemented:

-  When app opened, it asks for location services permission. If allowed, then show the businesses for current location. Else use the default SFO location coordinates
- The selected categories will show up at the top of the list

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. auto layout of the business cell
2. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

Need to further tune the auto layout of business cell. Currently it works, but I have used businessNameLabel.preferredMaxLayoutWidth = distanceLabel.frame.origin.x - businessNameLabel.frame.origin.x - 20
So I am trying to further tune some constraint so that it will work without this.

Also I need to work on custom MKAnnotationView so that I can make it clickable on the MapView.

## License

    Copyright [2017] [Gauri Tikekar]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
