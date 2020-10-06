import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appxy/services/location_services.dart';
import 'package:flutter_appxy/size_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  MapType mapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();
  LocationServices _locationServices;
  LocationData _locationData;
  CameraPosition _cameraPosition;
  Set<Marker> allMapMarkers;
  Marker userPicker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _locationServices=Provider.of<LocationServices>(context);



    return FutureBuilder(
      future: _locationServices.getLocation().then((LocationData value) => _locationData=value),
      builder:(context,snapshot){
        if(_locationData==null){
         return Center(child: CircularProgressIndicator());
        }else{
          _cameraPosition=CameraPosition(target:LatLng(_locationData.latitude,_locationData.longitude),zoom: 19);
          setupMarkers();
          return SafeArea(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: _cameraPosition,
                  mapType: mapType,
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  markers: allMapMarkers,
                ),

                Positioned(
                  left: MediaQuery.of(context).size.width - 70,
                  top: 50,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          color: Color.fromRGBO(250, 246, 235, 1),
                          child: Icon(
                            Icons.gps_fixed,
                          ),
                          onPressed: () async {
                            final GoogleMapController controller =
                            await _controller.future;
                            await _locationServices.getLocation().then((LocationData value) => _locationData=value);
                            _cameraPosition=CameraPosition(target:LatLng(_locationData.latitude,_locationData.longitude),zoom: 19);

                            controller.animateCamera(CameraUpdate.newCameraPosition(
                                _cameraPosition));
                          },
                        ),
                        RaisedButton(
                          color: Color.fromRGBO(250, 246, 235, 1),
                          onPressed: () {
                            setState(() {
                              mapType = mapType == MapType.normal
                                  ? MapType.satellite
                                  : MapType.normal;
                            });
                          },
                          child: Icon(MdiIcons.googleEarth, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 70,
                        width: MediaQuery.of(context).size.width - 16,
                        child: RaisedButton(
                          child: Center(
                            child: Text(
                              "تأكيد الموقع",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(50),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          color: const Color(0xFF1DBF73),
                          onPressed: () {},
                        ),
                      ),
                    )),
              ],
            ),
          );
        }
      } ,
    );
  }

  onMapCreated(controller) {
    setState(() {
      _controller.complete(controller);
    });
  }

  void setupMarkers() {
    allMapMarkers =new HashSet();
    userPicker=new Marker(
      markerId: MarkerId("userPicker"),
      draggable:true,
      position: LatLng(_locationData.latitude,_locationData.longitude),
      onTap: (){print(userPicker.toString());}
    );
    allMapMarkers.add(userPicker);
    userPicker.toString();


  }
}
