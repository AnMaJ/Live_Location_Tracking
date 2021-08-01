import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';


class Locationpage extends StatefulWidget {
   Locationpage({Key? key, required this.grpuid,required this.name,required this.email,required this.locdata,required this.grpname}) : super(key: key);
String grpuid='';
String name='';
   String grpname='';
   String email='';
   LocationData locdata;
  @override
  _LocationpageState createState() => _LocationpageState();
}

class _LocationpageState extends State<Locationpage> {
   late GoogleMapController mapController;
   BehaviorSubject<double> radius=BehaviorSubject();
   late Stream<List<DocumentSnapshot>> stream;
   List<Marker> markers = [];
   double _value = 1.0;
   String _label = '';

   changed(value){
     setState(() {
       _value=value;
       _label='${_value.toInt().toString()}kms';
       radius.add(value);
       markers.clear();

     });

   }

   void _updateMarkers(List<DocumentSnapshot> documentList) {
     markers.clear();
     print('updated markers');
     documentList.forEach(
           (DocumentSnapshot document) {
         GeoPoint point = document['position']['geopoint'];
         String name = document['name'];
         _addMarker(point.latitude, point.longitude, name);
       },
     );
   }

   void _addMarker(double lat, double lng, String name) {
     var _marker = Marker(
         markerId: MarkerId(UniqueKey().toString()),
         position: LatLng(lat, lng),
         icon: name == name
             ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
             : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
         infoWindow: InfoWindow(title: name, snippet: '${lat},${lng}'));
     setState(() {
       markers.add(_marker);
     });
   }

   late LocationData _currentPosition;



   getLoc() async {
     bool _serviceEnabled;
     PermissionStatus _permissionGranted;

     Location location = Location();


     _serviceEnabled = await location.serviceEnabled();
     if (!_serviceEnabled) {
       _serviceEnabled = await location.requestService();
       if (!_serviceEnabled) {
         return;
       }
     }

     _permissionGranted = await location.hasPermission();
     if (_permissionGranted == PermissionStatus.denied) {
       _permissionGranted = await location.requestPermission();
       if (_permissionGranted != PermissionStatus.granted) {
         return;
       }
     }

     _currentPosition = await location.getLocation();

     location.onLocationChanged.listen((LocationData currentLocation) {
       GeoFirePoint myLocation=Geoflutterfire()
       .point(latitude: currentLocation.latitude as double,longitude:currentLocation.longitude as double);
       dbadd(myLocation);
       print("${currentLocation.latitude} : ${currentLocation.longitude}");
       setState(() {
         _currentPosition = currentLocation;
       });
     });
   }

   @override
   void initState() {

     super.initState();


     _currentPosition=widget.locdata;
     print(_currentPosition.latitude!);
     getLoc();
     GeoFirePoint center=
     Geoflutterfire().point(latitude: _currentPosition.latitude!,longitude: _currentPosition.longitude! );
     stream=radius.switchMap((rad){
       return Geoflutterfire()
           .collection(
           collectionRef:
           FirebaseFirestore.instance.collection('groups').doc(widget.grpuid).collection('locations'))
           .within(
           center: center, radius: rad, field: 'position',strictMode: true);

     });

   }
Future<void> dbadd(GeoFirePoint myLocation)async{

     FirebaseFirestore.instance.collection('groups').doc(widget.grpuid).collection('locations').doc(widget.email)
         .set({'name': widget.name,'position':myLocation.data});
}

   late GoogleMapController _controller;
   @override
   void dispose() {
     setState(() {
       _controller.dispose();
     });
     super.dispose();
   }
   void _onMapCreated(GoogleMapController _ctrlr) {
     print('yeeeeeehow');
     _controller = _ctrlr;
     Location location = Location();
     location.onLocationChanged.listen((l) async {
       print(l.latitude);
       GeoFirePoint myloc = Geoflutterfire()
           .point(latitude: l.latitude!, longitude: l.longitude!);
       dbadd(myloc);
     });
     stream.listen((List<DocumentSnapshot> documentList) {
       _updateMarkers(documentList);
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group: ${widget.grpname}',style: GoogleFonts.pacifico(fontSize: 30.0,color: Colors.white),),
        backgroundColor: Colors.brown[900],
        toolbarHeight: 70.0,
      ),
      body:

       Center(
        child: Column(
          children: <Widget>[
           Stack(
               children: [Container(
                   height: MediaQuery.of(context).size.height-170-13.143,
                   width: MediaQuery.of(context).size.width,

              child:GoogleMap(

          myLocationEnabled: true,
                mapType: MapType.normal,
                onMapCreated: (_controller) {

                  _onMapCreated(_controller);
                },

                markers: markers.toSet(),
                initialCameraPosition: CameraPosition(

            target: LatLng(_currentPosition.latitude!,_currentPosition.longitude!),
            zoom: 10.0,
          ),


              )),



               ]),
            Text('Adjust the scale to find people around you'),


            Slider(
              min: 0,
              max: 1001,
              divisions: 200,
              value: _value,
              label: _label,
              activeColor: Colors.brown,
              inactiveColor: Colors.grey[100],
              onChanged: (double value)=>changed(value),
            )
          ]
        )
      )
    );
  }

}






