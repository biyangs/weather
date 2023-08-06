
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather",
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Weathering with U"),),
          backgroundColor: Colors.amber,
        ),
        body: const LogInform(),
      ),
    );
  }
}

class LogInform extends StatelessWidget {
  const LogInform({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController(); //username: admin
    final TextEditingController passwordController = TextEditingController(); //password: admin
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your password'
            ),
          ),
        ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: (){
                String enteredUsername = usernameController.text;
                String enteredPassword = passwordController.text;

                if((enteredUsername == 'admin')&&(enteredPassword == 'admin')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewForm(),
                    ),
                  );
                }
                else{
                print('wrong account');
                }
              },
              child: Text('Log In'),
            ),
            )
      ]
    );
  }}

class NewForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _NewFormState createState() => _NewFormState();
}
class _NewFormState extends State<NewForm> {
  String cityName = 'Manila'; //your preferred city to locate
  double temperature = 0.0; 
  String weatherDescription = 'Weather data will appear here';

  Future<void> fetchWeatherData() async { //using future to get a result and async for fetching data to a network
    const apiKey = '3ea5eb6b7080418abe98482c49b6b1a2'; //there are many api that are free but has limited and you can get this api 

    // ignore: unnecessary_string_interpolations
    final url = Uri.https('api.weatherbit.io', '/v2.0/current', {'city': city, 'key': apiKey}); //this is the example method for opening url in weatherbit
    //and there are method that depends of what weather api you will use
    final response = await http.get(url); 

    if (response.statusCode == 200) { 
      final data = json.decode(response.body);
      final main = data['data'];
      final main2 = main[0];
      temperature = main2['temp'];
      setState(() {
        cityName = main2['city_name'];
        temperature = main2['temp'];
        weatherDescription = main2['weather']['description']; 
      });
    } else {
      setState(() {
        cityName = 'City Not Found';
        temperature = 0.0;
        weatherDescription = 'Failed to fetch weather data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather U'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Weather Updates',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeatherData,
              child: Text('Get Weather Data'),
            ),
            SizedBox(height: 10),
            Text(
              'City: $cityName\nTemperature: $temperature°C\nDescription: $weatherDescription',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
//don't forget to paste <uses-permission android:name="android.permission.INTERNET" /> this in your androidmanifest.xml
//for more questions regarding to this project you can contact me in my email:alejoralphivan@gmail.com
