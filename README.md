# weather_app
# Flutter Weather App

A simple weather application built with Flutter that fetches current weather information based on the user's location or a specified city. The app saves the last searched location and displays it upon relaunch.

## Features

- Fetches weather information for the current location.
- Allows the user to search for weather information by city name.
- Saves the last searched location and displays the weather information for that location upon relaunch.
- Displays weather details including temperature, description, and date/time.
- Capitalizes the first letter of each word in the weather description.

## Getting Started
### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Android Studio or Visual Studio Code (with Flutter and Dart plugins installed)

### Dependencies
flutter:                      The Flutter SDK.
intl:                         For date and time formatting.
weather:                      For fetching weather information from the OpenWeatherMap API.
shared_preferences:           For saving the last searched location.
geolocator:                   For getting the user's current location.
geocoding:                    For converting coordinates into a human-readable address.
#   w e a t h e r a p p 
