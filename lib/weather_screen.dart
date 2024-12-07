import 'package:flutter/material.dart';
import 'weather_api.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String? _weatherInfo;
  bool _isLoading = false;

  Future<void> _getWeatherData() async {
    setState(() {
      _isLoading = true;
      _weatherInfo = null;
    });
    try {
      final cityName = _cityController.text;
      final weatherData = await fetchWeatherData(cityName);
      setState(() {
        _weatherInfo =
            'Cuaca di ${weatherData["name"]}: ${weatherData["main"]["temp"]}°C, ${weatherData["weather"][0]["description"]}';
      });
    } catch (e) {
      setState(() {
        _weatherInfo = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Cuaca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Masukkan Nama Kota',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _getWeatherData,
              child: _isLoading ? CircularProgressIndicator() : Text('Cari Cuaca'),
            ),
            SizedBox(height: 16.0),
            if (_weatherInfo != null)
              Text(
                _weatherInfo!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
          ],
        ),
      ),
    );
  }
}