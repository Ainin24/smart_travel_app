import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewPlace extends StatefulWidget {
  @override
  _ViewPlaceState createState() => _ViewPlaceState();
}

class _ViewPlaceState extends State<ViewPlace> {
  List<dynamic> places = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPlaces();
  }

  Future<void> _fetchPlaces() async {
    final url = Uri.https(
      'smarttravelplanner-c5583-default-rtdb.asia-southeast1.firebasedatabase.app',
      'registerplace.json',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          places = data.entries
              .map((entry) => {...entry.value, 'id': entry.key})
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage =
              'Failed to load places. Status code: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error fetching places: $error';
        isLoading = false;
      });
    }
  }

  Future<void> _deletePlace(String id) async {
    final url = Uri.https(
      'smarttravelplanner-c5583-default-rtdb.asia-southeast1.firebasedatabase.app',
      'registerplace/$id.json',
    );

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Place deleted successfully!');
        _fetchPlaces(); // Refresh the list after deletion
      } else {
        print('Failed to delete place. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Places'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/travel-bg10.jpg'), fit: BoxFit.cover),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (BuildContext context, int index) {
                      final place = places[index];
                      return Card(
                        elevation: 4.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(place['travelerName'] ?? 'Unnamed'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(place['travelerAddress'] ??
                                  'No address available'),
                              Text(place['tripLocation'] ??
                                  'No location available'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deletePlace(place['id']);
                            },
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
