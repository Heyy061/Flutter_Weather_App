import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Additional_info.dart' show Additionalinfo;
import 'package:weather_app/ApiKey.dart' show weatherApiKey;
import 'package:weather_app/Hourly_info.dart' show HourlyInfo;
import 'package:weather_app/NextAdditional_info.dart' show NextAdditional_info;
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentData();
  }

  Future<Map<String, dynamic>> getCurrentData() async {
    try {
      String cityName = "New Delhi";
      final result = await http.get(
        Uri.parse(
          //"Uri.parse" to convert url string to uri object ,URI stands for Uniform Resource Identifier.
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$weatherApiKey&units=metric',
        ), // 'uri' It is an object that represents the address of a resource on the internet
      );
      final data1 = jsonDecode(result.body);
      if (data1['cod'] != '200') {
        //or we can aslo write (result.body==200)
        //cod=200 then it mean api have data and it is working correctly
        throw "Unexpected Error";
      } else {
        return data1;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Weather App",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),

      body: FutureBuilder(
        //for loading,error
        future: getCurrentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error
                    .toString(), //cuz this is object and we want to return it that why we covert it to string
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            );
          }

          final data = snapshot.data!;
          final currentWeather = data['list'][0]; //just a improvmemt

          final pTemp = currentWeather['main']['temp'].round();
          //** weather is LIST unlike of temp which were map
          final pSky = currentWeather['weather'][0]['main'];
          final humi = currentWeather['main']['humidity'].round();
          final press = currentWeather['main']['pressure'].round();
          final vis = currentWeather["visibility"].round();
          final visK = (vis / 1000).toString();
          final speed = currentWeather['wind']['speed'].toStringAsFixed(1);
          final cityName = data['city']['name'];

          return Padding(
            //Loading
            // handle all column
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // so that always starts from left

                    children: [
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(
                          "$cityName",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        child: SizedBox(
                          width: double.infinity,

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusGeometry.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.1, 0.1),
                                  blurRadius: 1,
                                  spreadRadius: 0.1,
                                ),
                              ],
                            ),

                            child: Card(
                              //like a container but have elavation
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Color.fromRGBO(236, 239, 239, 0.475),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),

                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 5,
                                    sigmaY: 5,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "$pTemp°C", //temp
                                          style: TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight(550),
                                            color: Color.fromRGBO(
                                              250,
                                              239,
                                              235,
                                              1,
                                            ),
                                          ),
                                        ),

                                        Icon(
                                          pSky == 'Clouds'
                                              ? Icons.cloud
                                              : pSky == "Rain"
                                              ? Icons.beach_access
                                              : Icons.wb_sunny,

                                          size: 40,
                                          fontWeight: FontWeight(500),
                                          color: Color.fromRGBO(
                                            238,
                                            237,
                                            236,
                                            1,
                                          ),
                                        ),
                                        // SizedBox(height: 3),
                                        Text(
                                          "$pSky",
                                          style: TextStyle(fontSize: 28),
                                        ),
                                        // SizedBox(
                                        // height: 12,
                                        // ), //to space bw cloud and rain
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ////////////////////////////////////////////////////////////////////
                      //Middle
                      SizedBox(height: 20),
                      const Text(
                        "Hourly Forecast",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),

                      /////////////////////////////////////////////////////////////////////////////
                      // SingleChildScrollView(
                      //   //for scrolling cards
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       for (int i = 0; i <= 6; i++)
                      //         HourlyInfo(
                      //           time: data['list'][i + 1]['dt'].toString(),
                      //           icon2:
                      //               data['list'][i + 1]['weather'][0]['main'] ==
                      //                       "clouds" ||
                      //                   data['list'][i + 1]['weather'][0]['main'] ==
                      //                       'Rain'
                      //               ? Icons.cloud
                      //               : Icons.wb_sunny,
                      //           temp: data['list'][i + 1]['main']['temp']
                      //               .toString(),
                      //         ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 125,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final hourlyForcast = data['list'][index + 1];
                            final hourlySky =
                                hourlyForcast['weather'][0]['main'];
                            final hourlyTemp = hourlyForcast['main']['temp']
                                .round();

                            //// import new dependieces 'intl'
                            final time = DateTime.parse(
                              hourlyForcast['dt_txt'],
                            );
                            final hour = time.hour;
                            final isNight = hour >= 19 || hour <= 6;
                            return HourlyInfo(
                              time: DateFormat.Hm().format(time), //Time

                              icon2: hourlySky == "Clouds"
                                  ? Icons.cloud_circle
                                  : hourlySky == "Rain"
                                  ? Icons.beach_access
                                  : isNight
                                  ? Icons.nightlight_round
                                  : Icons.wb_sunny_sharp,

                              //icon
                              temp: "$hourlyTemp°C", //Temperature
                            );
                          },
                        ),
                      ),

                      ////////////////////////// Third Part
                      SizedBox(height: 24),
                      const Text(
                        "Additional Infomation",
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),

                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Additionalinfo(
                              icon1: Icons.water_drop,
                              label: "Humidity",
                              value: "$humi%",
                            ),

                            Additionalinfo(
                              icon1: Icons.av_timer,
                              label: "Pressure",
                              value: "$press mb",
                            ),
                            Additionalinfo(
                              icon1: Icons.wb_sunny,
                              label: "UV Index",
                              value: "6",
                            ),
                          ],
                        ),
                      ),
                      //////////////////////////////////////////////////////////////
                      const SizedBox(height: 28),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // SizedBox(width: 18),
                            NextAdditional_info(
                              icon3: Icons.visibility,
                              index: "Visibility",
                              value: "$visK Km ",
                            ),
                            // SizedBox(width: 30),
                            NextAdditional_info(
                              icon3: Icons.air,
                              index: "Wind Speed",
                              value: "$speed Km/Hr",
                            ),
                            // SizedBox(width: 45),
                            NextAdditional_info(
                              icon3: Icons.blur_on,
                              index: "AQI",
                              value: "120",
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
