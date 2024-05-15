import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/home_page_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () { 
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("lib/images/cloud.png"),
          fit: BoxFit.cover
          ),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50,),
            Image.asset("lib/images/weather.png",height: 250,),
            const SizedBox(height: 75,),
            const Text("Weather",style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold),),
            const Text("We show weather for you",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.normal
            ),
            ),
            const SizedBox(height: 50,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                
              ),
              onPressed: () {
              
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
              
            }, child: const Text("Skip",style: TextStyle(fontSize: 20),))
            
          ],
        ),
      ),
    );
    
  }
}