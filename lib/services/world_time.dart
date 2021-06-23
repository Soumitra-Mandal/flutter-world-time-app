import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String time;
  String flag;
  String url;
  bool isDaytime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response res =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(res.body);

      ///print(data);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
    } catch (e) {
      print('Caught Error: $e');
      time = "could not get time data";
    }
  }
}
