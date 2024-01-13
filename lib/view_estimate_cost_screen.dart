import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_travel_app/cost_detail.dart';

class ViewCost extends StatefulWidget {
  @override
  _ViewCostState createState() => _ViewCostState();
}

class _ViewCostState extends State<ViewCost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController destinationController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController dateStartController = TextEditingController();
  TextEditingController dateEndController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController budgetTripController = TextEditingController();

  Future<void> _cost() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.https(
        'smarttravelplanner-c5583-default-rtdb.asia-southeast1.firebasedatabase.app',
        'cost.json',
      );

      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              'destination': destinationController.text,
              'duration': durationController.text,
              'dateStart': dateStartController.text,
              'dateEnd': dateEndController.text,
              'activity': activityController.text,
              'budgetTrip': budgetTripController.text
            },
          ),
        );

        if (response.statusCode == 200) {
          print('Place registered successfully!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CostDetail(),
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

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cost Trip'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/travel-bg10.jpg'), fit: BoxFit.cover),
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
                      controller: destinationController,
                      decoration: _buildInputDecoration('Destination'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your destination';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: durationController,
                      decoration: _buildInputDecoration('Duration'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your duration';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: dateStartController,
                      decoration: _buildInputDecoration('Start Date'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: dateEndController,
                      decoration: _buildInputDecoration('End Date'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: activityController,
                      decoration: _buildInputDecoration('Activity Details'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the activity';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: budgetTripController,
                      decoration: _buildInputDecoration('Budget for trip'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the budget';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: _cost,
                      child: Text('Create cost'),
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
