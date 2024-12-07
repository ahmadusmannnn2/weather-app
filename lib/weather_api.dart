import 'dart:convert';
import 'package:http/http.dart' as http;

// Ganti YOUR_API_KEY dengan API key dari OpenWeatherMap Anda
const String apiKey = '7f517332b8da39ae355184c225cd14eb'; 

Future<Map<String, dynamic>> fetchWeatherData(String cityName) async {
  try {
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch weather data: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}