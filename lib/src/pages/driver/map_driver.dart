import 'package:fast_go/src/pages/driver/map_driver_controller.dart';
import 'package:fast_go/src/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDriver extends StatefulWidget {
  @override
  _MapDriverState createState() => _MapDriverState();
}

class _MapDriverState extends State<MapDriver> {
  MapDriverController _con = new MapDriverController();

  @override
  void initState() {
    // TODO: implement initState

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      body: Stack(
        children: [
          _googleMapsWidget(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_btnMenu(), _btnPosition()],
                ),
                Expanded(child: Container()),
                _btnConnect()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _btnPosition() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.location_searching,
              color: Colors.grey,
              size: 20,
            ),
          )),
    );
  }

  Widget _btnMenu() {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu, color: Colors.white),
      ),
    );
  }

  Widget _btnConnect() {
    return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      child: ButtonApp(
        text: 'Conectarse',
        color: Colors.blueAccent,
        textColor: Colors.white,
      ),
    );
  }

  Widget _googleMapsWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreaated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),
    );
  }

  void refresh() {
    setState(() {});
  }
}
