# Minimal Weather App

## Reason for Creation

I am currently in the process of learning Flutter and I wanted to create a weather app as this would be a good way to learn the basics around understanding how to make API requests and displaying them uniquely 

## What occurs in this project?

In this project, I make use of the openweathermap API to get data about the weather based on the location of the user. I got the location of the user utilising the geocoding and geolocator package that can be downloaded into Flutter. After using geocoding I pass the latitudes and longitudes into the geolocator to find the city, and then pass this into the API, returning the values I required that were:
- Conditions (Cloudy, Overcast, Thunderstorm, etc)
- Temperature
  - Maximum
  - Minimum
  - Actual Temperature
  - Feels Like (as often this is what people will be experiencing outside)

## What more might be there?

If I do come back to this project (currently as of writing this the motivation is quite high 😅) I would like to implement a feature that would allow for a navigation bar at the bottom with a home page (which would be your locations temperature) but another page called "Other" wherein you would be able to see other locations weather (which you would have saved as favourites)

## What the App looks like

![Untitled design-2](https://github.com/AshwathSingh/Minimal-Weather-App/assets/143448570/5674b21d-44aa-458c-af07-c5f168683219)


