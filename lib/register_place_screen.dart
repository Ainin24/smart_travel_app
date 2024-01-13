import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_travel_app/view_place.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _travelerNameController = TextEditingController();
  final TextEditingController _travelerAddressController =
      TextEditingController();
  final TextEditingController _tripLocationController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.https(
        'smarttravelplanner-c5583-default-rtdb.asia-southeast1.firebasedatabase.app',
        'registerplace.json',
      );

      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              'travelerName': _travelerNameController.text,
              'travelerAddress': _travelerAddressController.text,
              'tripLocation': _tripLocationController.text
            },
          ),
        );

        if (response.statusCode == 200) {
          print('Place registered successfully!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ViewPlace(),
            ),
          );
        } else {
          print(
              'Failed to register place. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error occurred: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip & Journey'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/travel-bg10.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _travelerNameController,
                      decoration: InputDecoration(
                        labelText: 'Traveler Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _travelerAddressController,
                      decoration: InputDecoration(
                        labelText: 'Traveler Address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _tripLocationController,
                      decoration: InputDecoration(
                        labelText: 'Trip Location',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your trip location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Register Place'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
