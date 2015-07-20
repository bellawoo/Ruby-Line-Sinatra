# The Ruby Line - v1 Sinatra
Making your DC commute a little less painful. Get to where you need to go. Know what's coming next.

Built in Sinatra as part of a collaborative project with a Front-End Student from The Iron Yard. This project was later ported to Rails and adapted for iOS app development purposes. You can find that repo under ["Green Apple Line."](https://github.com/bellawoo/Green-Apple-Line "Green Apple Line on Github")

I loved working on this project so much that I decided to add even more features. The full product will be featured at The Iron Yard May 2015 cohort Demo Day as my final project.

## Features
WMATA Metrorail predictions

This will pull data for arrival predictions for the station closest to a fixed location. Location is based on latitude and longitude and must be passed in as parameters.

```GET "/rail/:lat/:long"```

Capital BikeShare information

This will pull data for dock and bike availabilities for the 5 closest docking stations to a fixed location. Location is based on latitude and longitude and must be passed in as parameters.

```GET "/bike/:lat/:long"```


## Future Features
WMATA Bus predictions

This will pull data for arrival predictions for bus stops within 1mi of a fixed location. Location is based on latitude and longitude and must be passed in as parameters.

```GET "/bus/:lat/:long"```


Fare Estimate Calculator
Get real time fare estimates for yourself or a group of people from one destination to another. Determine if it's worth your time to save a dollar or two by riding WMATA or if it's peak of the peak and calling an Uber might be more worth it.
