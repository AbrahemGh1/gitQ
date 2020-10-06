import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appxy/services/location_services.dart';
import 'package:flutter_appxy/views/google_map/components/body.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../size_config.dart';

class GoogleMapScreen extends StatefulWidget {
  static var routeName = "views.GoogleMapScreen";
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Provider<LocationServices>(
      create: (context) => LocationServices(),
      child: Scaffold(
        appBar: buildAppBar(),
        body: Body(),
      ),
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * .13),
      child: AppBar(
        backgroundColor: const Color(0XFFF6F6F6),
        shadowColor: const Color(0XFFB5B5B5),
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "حدد موقع",
          style: headingStyle,
        ),
        actions: [],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: new Container(
              margin: const EdgeInsets.only(
                  left: 20, top: 0, right: 20, bottom: 20),
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      new BorderRadius.all(new Radius.circular(10.0))),
              child: new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new TextField(
                    style: new TextStyle(fontSize: 22.0, color: Colors.black),
                    decoration: new InputDecoration(
                      filled: true,
                      fillColor: Color(0XFFE3E3E5),
                      hintText: 'ابحث عن موقع',
                      contentPadding: const EdgeInsets.only(
                          right: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.transparent),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.transparent),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ))),
        ),
      ),
    );
  }
}
