import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/weather_model.dart';
import '../../provider/api.dart';
import '../../provider/themeProvider.dart';
import 'SearchScreen.dart';

class HomePage extends StatefulWidget {
  final cityname;

  const HomePage({Key? key, this.cityname}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherResponseModel? wm;

  get connectionStatus => null;

  @override
  fetchData(String text) async {
    await Provider.of<APICallProvider>(context, listen: false)
        .fetchApiData(text)
        .then((value) {
      setState(() {
        wm = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final datetime = "${DateTime.now().hour}:${DateTime.now().minute}";
    return connectionStatus.toString() == "ConnectivityResult.wifi" ||
            connectionStatus.toString() == "ConnectivityResult.mobile"
        ? SafeArea(
            child: Scaffold(
                body: (wm != null)
                    ? SafeArea(
                        child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/back.jpg"),
                                fit: BoxFit.fill,
                                opacity: 0.4)),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          appBar: AppBar(
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                            title: Text(
                              "${wm?.location?.name}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            centerTitle: true,
                            leading: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchPage(),
                                      ));
                                }),
                            actions: [
                              Consumer<ModelTheme>(
                                builder: (context, themevalue, child) {
                                  return PopupMenuButton<int>(
                                    itemBuilder: (context) => [
                                      // PopupMenuItem 1
                                      PopupMenuItem(
                                        value: 1,
                                        // row with 2 children
                                        child: Row(
                                          children: [
                                            Icon(Icons.sunny),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Light ")
                                          ],
                                        ),
                                      ),
                                      // PopupMenuItem 2
                                      PopupMenuItem(
                                        value: 2,
                                        // row with two children
                                        child: Row(
                                          children: [
                                            Icon(Icons.shield_moon_rounded),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Dark")
                                          ],
                                        ),
                                      ),
                                    ],
                                    elevation: 2,
                                    // on selected we show the dialog box
                                    onSelected: (value) {
                                      // if value 1 show dialog
                                      if (value == 1) {
                                        themevalue.isDark = false;
                                        // if value 2 show dialog
                                      } else if (value == 2) {
                                        themevalue.isDark = true;
                                      }
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                          body: CustomScrollView(
                            physics: BouncingScrollPhysics(
                                decelerationRate: ScrollDecelerationRate.fast),
                            scrollDirection: Axis.vertical,
                            slivers: [
                              SliverAppBar(
                                automaticallyImplyLeading: false,
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                expandedHeight: 250,
                                flexibleSpace: Container(
                                  child: Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text:
                                                "${wm?.timelines!.minutely![0].values!['temperature']}ºc",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 60)),
                                        TextSpan(
                                            text:
                                                "\n${wm?.timelines!.minutely![0].values!['temperatureApparent']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 30)),
                                        TextSpan(
                                            text: "/",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 30,
                                                color: Colors.white
                                                    .withOpacity(0.4))),
                                        TextSpan(
                                            text:
                                                "${wm?.timelines!.minutely![0].values!['temperature']}\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 30)),
                                        TextSpan(
                                            text:
                                                DateFormat('dd-MM-yyyy HH:MM a')
                                                    .format(wm
                                                            ?.timelines!
                                                            .minutely![0]
                                                            .time! ??
                                                        DateTime.now()),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 30)),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 20, right: 20, left: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "3-Day forecast",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Spacer(),
                                          Text("More Details ▶",
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //   Image.file(File(wm.forecast!.forecastday![0].day!.condition!.icon.toString())),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("Today"),
                                          Spacer(),
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "${wm?.timelines!.daily![0].values!.temperatureMax}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              TextSpan(
                                                  text: "/",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white
                                                          .withOpacity(0.4))),
                                              TextSpan(
                                                  text:
                                                      " ${wm?.timelines!.daily![0].values!.temperatureMin}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ]),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //  Image.file(File(wm.forecast!.forecastday![0].day!.condition!.icon.toString())),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("Tommorrow"),
                                          Spacer(),
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      " ${wm?.timelines!.daily![1].values!.temperatureMax}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              TextSpan(
                                                  text: "/",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white
                                                          .withOpacity(0.4))),
                                              TextSpan(
                                                  text:
                                                      "${wm?.timelines!.daily![0].values!.temperatureMin}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ]),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("Next Day"),
                                          Spacer(),
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      " ${wm?.timelines!.daily![2].values!.temperatureMax}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              TextSpan(
                                                  text: "/",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white
                                                          .withOpacity(0.4))),
                                              TextSpan(
                                                  text:
                                                      " ${wm?.timelines!.daily![2].values!.temperatureMin}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ]),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(10),
                                        child: Center(
                                          child: Text("3 Day forecast"),
                                        ),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.access_time_filled_rounded,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "24-hour forecast",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 150,
                                        child: ListView.separated(
                                          itemCount: 24,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              width: 10,
                                            );
                                          },
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color((math.Random()
                                                                .nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt())
                                                    .withOpacity(0.3),
                                              ),
                                              height: 70,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    DateFormat('HH:MM').format(
                                                        wm
                                                                ?.timelines!
                                                                .hourly![index]
                                                                .time ??
                                                            DateTime.now()),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      "${wm?.timelines?.hourly![index].values!["temperatureApparent"]} º"),
                                                  Text(
                                                      "${wm?.timelines?.hourly![index].values!["windSpeed"]}"),
                                                  Text(".km/h"),
                                                  Image.network(
                                                    "https://www.iconsdb.com/icons/preview/white/chance-of-storm-xxl.png",
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            height: 150,
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5),
                                            child: Center(
                                              child: Text(
                                                  "Wing Speed \n${wm?.timelines!.daily![0].values!.windSpeedAvg}km/h"),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 10, bottom: 10),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            height: 150,
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5),
                                            child: Center(
                                                child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: " Sunrise",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black)),
                                                TextSpan(
                                                    text:
                                                        "\n${DateFormat('HH:MM').format(wm!.timelines!.daily![0].values!.sunsetTime ?? DateTime.now())}",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                TextSpan(
                                                    text: " Sunset",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black)),
                                              ]),
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 400,
                                      margin: EdgeInsets.only(right: 10),
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              20,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text("Humidity"),
                                            trailing: Text(
                                                "${wm?.timelines!.daily![0].values!.humidityAvg}"),
                                          ),
                                          ListTile(
                                            title: Text("Rain Intensity"),
                                            trailing: Text(
                                                "${wm?.timelines!.daily![0].values!.rainIntensityAvg}"),
                                          ),
                                          ListTile(
                                            title: Text("UV"),
                                            trailing: Text(
                                                "${wm?.timelines!.daily![0].values!.uvHealthConcernAvg}"),
                                          ),
                                          ListTile(
                                            title: Text("Pressure"),
                                            trailing: Text(
                                                "${wm?.timelines!.daily![0].values!.pressureSurfaceLevelAvg}"),
                                          ),
                                          ListTile(
                                            title: Text("Chance of rain"),
                                            trailing: Text(
                                                "${wm?.timelines!.daily![0].values!.rainAccumulationLweMax} %"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // fillOverscroll: true,
                                // hasScrollBody: true,
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.masks),
                                    title: Text("AQI117"),
                                    trailing:
                                        Text("Full air quality forecast ▶"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                    : Center(
                        child: CircularProgressIndicator(),
                      )))
        : SafeArea(
            child: Scaffold(
            body: Center(
              child: Text(
                "❌No Internet\n Check Your Internet Connection",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
              ),
            ),
          ));
  }
}
