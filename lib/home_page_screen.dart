import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/help_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  final TextEditingController _locationController = TextEditingController();
  String? _savedLocation;

  @override
  void initState() {
    
    super.initState();
    _loadSavedLocation();
  }

   Future<void> _loadSavedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedLocation = prefs.getString('location');
    });
    if (_savedLocation != null && _savedLocation!.isNotEmpty) {
      _fetchWeather(_savedLocation!);
    } else {
      _fetchWeatherForCurrentLocation();
    }
  }
  // fetch weather for the given city
  Future<void> _fetchWeather(String cityName) async{
    try{
      final weather = await _wf.currentWeatherByCityName(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }
   Future<void> _fetchWeatherForCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      String cityName = placemarks.first.locality ?? "Unknown location";
      _fetchWeather(cityName);
    } catch (e) {
      print(e);
    }
  }
  Future<void> _saveLocation(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI() ,
    );
  }

  Widget _buildUI(){
    if(_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
      child: 
      
      Column(
        mainAxisSize : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(height: 50,),
              GestureDetector(
               child: const SizedBox(
                width: 50,
                height: 50,
                child: Icon(Icons.keyboard_backspace),
               ),
               onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()),
                );
              },
                       ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: "Enter Location",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
          ),
          const SizedBox(height: 2,),
          ElevatedButton(onPressed: () {
              String location = _locationController.text;
              if (location.isEmpty) {
                _fetchWeatherForCurrentLocation();
              } else {
                _fetchWeather(location);
                _saveLocation(location);
              }
            },  child: const Text("Save Location")),
          const SizedBox(height: 20,),
      
          _locationHeader(),
          const SizedBox(          
            height: 24,
          ),
          
          _weatherIcon(),
           const SizedBox(
            height: 48,
          ),
          _currentTemp(),
        ],
      ),
      ),
    );
  }
  Widget _locationHeader(){
    return Text(
      _weather?.areaName??"",
    style: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w500,
    ),);
  }



  Widget _weatherIcon(){
    return Column(
       mainAxisSize : MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
            ),
            ),
          ),
        ),
              Text(_weather?.weatherDescription ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),),
      ],
    );
  }

  Widget _currentTemp(){
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
    style: const TextStyle(
      color: Colors.black,
      fontSize: 90,
      fontWeight: FontWeight.w500,
    ),
    );
  }
}