import 'package:flutter/material.dart';
import 'package:flutter_app/services/time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'New York', url: 'America/New_York', flag: 'usa.png');
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location' : instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'daycycle' : instance.dayCycle,
      'temp' : instance.temp    // changed
    });
  }

  @override
  void initState(){
    super.initState();
    setupWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child : SpinKitFadingCircle(
              color: Colors.white,
              size: 80.0,
            ),
        ),
    );
  }
}
