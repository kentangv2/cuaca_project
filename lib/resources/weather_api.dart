import 'dart:convert';
import "package:http/http.dart" as http;
import '../models/weather.dart';

Future<List<Weather>> fetchDailyWeather() async {
  final response = await http.get(Uri.parse('https://ibnux.github.io/BMKG-importer/cuaca/501568.json'));
  if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((weather) => new Weather.fromJson(weather))
          .toList();
    } else {
      throw Exception('Failed to load Weathers');
    }
}