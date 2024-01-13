import 'package:flutter/material.dart';
import 'package:smart_travel_app/create_itinerary_screen.dart';
import 'package:smart_travel_app/register_place_screen.dart';
import 'package:smart_travel_app/view_place.dart';
import 'package:smart_travel_app/welcome_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/register': (context) => Register(),
        '/view': (context) => ViewPlace(),
        '/itinerary': (context) => ItineraryScreen(),
      },
    );
  }
}
