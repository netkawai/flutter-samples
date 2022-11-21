import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  runApp(const MaterialApp(title: 'MapDemo', home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isMapCreated = false;

  bool _showUser = false;
  bool _zoomEnabled = false;
  bool _zoomGesturesEnabled = false;
  bool _scrollEnabled = false;
//  late Location location;
  late GoogleMapController _mapController;

  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(45.3531, -75.9147),
    zoom: 11.0,
  );

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      _isMapCreated = true;
    });
    //location = Location();
  }

  Widget _scrollToggler() {
    return SwitchListTile(
      title: const Text('ScrollGestures'),
      value: _scrollEnabled,
      onChanged: (bool value) {
        setState(() {
          _scrollEnabled = value;
        });
      },
    );
  }

  Widget _zoomToggler() {
    return SwitchListTile(
      title: const Text('ZoomGestures'),
      value: _zoomGesturesEnabled,
      onChanged: (bool value) {
        setState(() {
          _zoomGesturesEnabled = value;
        });
      },
    );
  }

  Widget _zoomControlsToggler() {
    return SwitchListTile(
      title: const Text('Zoom Control'),
      value: _zoomEnabled,
      onChanged: (bool value) {
        setState(() {
          _zoomEnabled = value;
        });
      },
    );
  }

  Widget _myLocationToggler() {
    return SwitchListTile(
      title: const Text('Show User'),
      value: _showUser,
      onChanged: (bool value) {
        setState(() {
          _showUser = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: _kInitialPosition,
      scrollGesturesEnabled: _scrollEnabled,
      zoomGesturesEnabled: _zoomGesturesEnabled,
      zoomControlsEnabled: _zoomEnabled,
      myLocationEnabled: _showUser,
      myLocationButtonEnabled: true,
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SizedBox(
            width: 300.0,
            height: 400.0,
            child: googleMap,
          ),
        ),
      ),
    ];

    if (_isMapCreated) {
      columnChildren.add(
        Expanded(
          child: ListView(
            children: <Widget>[
              _scrollToggler(),
              _zoomToggler(),
              _zoomControlsToggler(),
              _myLocationToggler(),
            ],
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map Demo'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: columnChildren,
        ));
  }
}
