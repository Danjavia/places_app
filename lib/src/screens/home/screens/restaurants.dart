import 'package:custom_app/src/repositories/cloud_firestore_repository.dart';
import 'package:custom_app/src/screens/home/screens/search_detail.dart';
import 'package:custom_app/src/screens/sign/login.dart';
import 'package:custom_app/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:hexcolor/hexcolor.dart';

class Restaurants extends StatefulWidget {
  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  GooglePlace googlePlace;
  List predictions = [];

  @override
  void initState() {
    googlePlace = GooglePlace("AIzaSyAGWfxNjTOEHHYVSIwdJaHFrwL34U0RIog");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurantes'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: InkWell(
              child: Icon(Icons.exit_to_app, size: 25.0, color: Colors.white,),
              onTap: () {
                _cloudFirestoreRepository.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                      (_) => false
                );
              },
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Escribe una ciudad",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black54,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  autoCompleteSearch(value);
                } else {
                  if (predictions.length > 0 && mounted) {
                    setState(() {
                      predictions = [];
                    });
                  }
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(predictions[index].description),
                    onTap: () {
                      debugPrint(predictions[index].placeId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            placeId: predictions[index].placeId,
                            googlePlace: googlePlace,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Hexcolor(purpleColor),
        child: Icon(Icons.location_searching, color: Colors.white,),
        onPressed: () async {
          LocationPermission permission = await requestPermission();
          print(permission);
          Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
          print(position);
          NearBySearchResponse result = await googlePlace.search.getNearBySearch(
              Location(lat: position.latitude, lng: position.longitude), 1500,
              type: "restaurant", keyword: "cruise");
          print(result.status);
        },
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    googlePlace = GooglePlace(PLACES_API_KEY);
    NearBySearchResponse result = await googlePlace.search.getNearBySearch(
        Location(lat: -33.8670522, lng: 151.1957362), 1500,
        type: "restaurant", keyword: "cruise");
    print(result.status);
    print(result.results);
    if (result != null && result.results != null && mounted) {
      setState(() {
        predictions = result.results;
      });
    }
  }
}
