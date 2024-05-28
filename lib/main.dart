// main.dart
import 'package:flutter/material.dart';


import 'home_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = WeatherService().fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Weather App'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: Colors.yellow,),
        centerTitle: true,
      ),
      body: Center(
        
        child: FutureBuilder<Map<String, dynamic>>(
          
          future: weatherData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final weatherList = snapshot.data!['list'];
              return ListView.builder(
                itemCount: weatherList.length,
                itemBuilder: (context, index) {
                  final weatherItem = weatherList[index];
                  final dateTime = DateTime.parse(weatherItem['dt_txt']);
                  final temp = weatherItem['main']['temp'];
                  final description = weatherItem['weather'][0]['description'];
                  return ListTile(
                    title: Text('$dateTime'),
                    subtitle: Text('Temp: $temp°K, $description'),
                    
                  );
                  
                },
              
              );
            }
          },
          
        ),
      ),
      
    );
  }
}
