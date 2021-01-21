import 'package:flutter/material.dart';
import 'package:flutter_app/services/time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isEmpty ? ModalRoute.of(context).settings.arguments : data;

    String bgimage;
    if(data['daycycle'] == 'evening')
      bgimage = 'evening.png';
    else if(data['daycycle'] == 'morning')
      bgimage = 'morning.png';
    else if(data['daycycle'] == 'afternoon')
      bgimage = 'afternoon.png';
    else if(data['daycycle'] == 'night')
      bgimage = 'night.png';
    else
      bgimage = 'error.png';

    return Scaffold(
      body: SafeArea(
        child : Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgimage'), // {evening & afternoon : black, night & mor:white,
              fit: BoxFit.cover
            )
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                child: Center(
                  child: FlatButton.icon(
                      onPressed: () async{
                       dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {
                            'time' : result['time'],
                          'location' : result['location'],
                          'flag': result['flag'],
                          'daycycle' : result['daycycle'],
                            'temp' : result['temp']    // changed
                          };
                        });
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      label: Text(
                          'choose location',
                        style: TextStyle(color: Colors.white),
                      ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                  data['location'],
                style: TextStyle(
                  fontSize: 28.0,
                  letterSpacing: 2.0,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                data['time'],
                style: TextStyle(
                    fontSize: 66.0,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                  '${data['temp']}° C',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
