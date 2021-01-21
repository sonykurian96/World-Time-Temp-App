import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

String api_key = "2f8796eefe67558dc205b09dd336d022";

class WorldTime {

  String location;
  String time;
  String url;
  String flag;
  String dayCycle;
  int temp;

  WorldTime({this.location,this.url,this.flag});

   Future<void> getTime() async
  {
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map dict = jsonDecode(response.body);

      // Temperature
        Response temporary = await get('http://api.openweathermap.org/data/2.5/weather?q=$location&appid=$api_key');
        Map data = jsonDecode(temporary.body);
        // data['main']['temp_max'], data['main']['temp_min'];
        double temperature = data['main']['temp'].toDouble();
        temp = temperature.round() - 273;

      // .............................
      String offset_hours = dict['utc_offset'].substring(0, 3);
      String offset_minutes = dict['utc_offset'].substring(4, 6);

      String datetime = dict['datetime'];

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset_hours), minutes: int.parse(offset_minutes)));

      if(now.hour >= 6 && now.hour < 8)
        dayCycle = 'morning';
      else if(now.hour >= 8 && now.hour < 17 )
        dayCycle = 'afternoon';
      else if(now.hour >= 17 && now.hour < 20)
        dayCycle = 'evening';
      else if(now.hour >= 20 )
        dayCycle = 'night';

      time = DateFormat.jm().format(now);

    } catch (e) {
      print('Error is :- $e');
      time = 'could not get the data';
    }
  }
}

