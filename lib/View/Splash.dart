import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DatabaseHelper.dart';
import '../Model/ChannelModel.dart';
import '../utils/key.dart';
import 'HomeScreen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  var handler = DbHelper();
  late SharedPreferences _pref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getInfo();
    timeOut();
  }
  getInfo() async {
    _pref = await SharedPreferences.getInstance();

    if (_pref.getString(MyKey.fetched) != "1") {
      handler.initDb().whenComplete(() async {
        await addPlanets();
        setState(() {
          _pref.setString(MyKey.fetched, "1");
        });
      });
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/logo.png",
              //fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
  void timeOut() async{
    Timer(Duration(seconds: 3), () async {
      print("printed after 3 seconds vvx");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

    });
  }
  Future<int> addPlanets() async {

    ChannelModel firstChannel = ChannelModel( channelName: "കിഴുപറമ്പ വാർത്തകൾ",channelLink: "https://chat.whatsapp.com/JSFSaLrb9YOFkCSiy4laFZ",specialName: "Ⓚⓘⓩⓗⓤⓟⓐⓡⓐⓜⓑⓐ ⓥⓐⓡⓣⓗⓐⓚⓐⓛ");
    ChannelModel secondChannel = ChannelModel(channelName: "DAILY MEDIA",channelLink: "https://chat.whatsapp.com/IFCtvqJjTSlJmAvTrfXz91",specialName: "𝔸ℝ𝔼𝔼𝕂𝕆𝔻𝔼 𝔻𝔸𝕀𝕃𝕐 𝕄𝔼𝔻𝕀𝔸");
    ChannelModel thirdChannel = ChannelModel(channelName: "മലപ്പുറം news",channelLink: "https://chat.whatsapp.com/E0Yn3xzR8mL3UAh9R8zkvP",specialName: "🄼🄰🄻🄰🄿🄿🅄🅁🄰🄼 🄽🄴🅆🅂");
    ChannelModel fourthChannel = ChannelModel(channelName: "ഊർങ്ങാട്ടിരി LIVE",channelLink: "https://chat.whatsapp.com/FAMOMXftkBy6ROEXgvCbQb",specialName: "🆄︎🆁︎🅰︎🅽︎🅶︎🅰︎🆃︎🆃︎🅸︎🆁︎🅸︎ 🅻︎🅸︎🆅︎🅴︎");
    ChannelModel fiveChannel = ChannelModel(channelName: "ചീക്കോട് news",channelLink: "https://chat.whatsapp.com/LOENPm6qMX71JmtP0U9mA1",specialName: "🅒︎🅗︎🅔︎🅔︎🅚︎🅞︎🅓︎🅔︎ 🅝︎🅔︎🅦︎🅢︎");
    ChannelModel sixthChannel = ChannelModel(channelName: "KAVANUR DAILY MEDIA",channelLink: "https://chat.whatsapp.com/BBY9YDrRDm8HydnipP5D3T",specialName: "🄺🄰🅅🄰🄽🅄🅁 🄳🄰🄸🄻🅈 🄼🄴🄳🄸🄰");
    ChannelModel sevenChannel = ChannelModel(channelName: "മഞ്ചേരി ടൈംസ്",channelLink: "https://chat.whatsapp.com/DKK820z7xO4KzZqJ7L6IQg",specialName: "🅜︎🅐︎🅝︎🅙︎🅔︎🅡︎🅘︎ 🅣︎🅘︎🅜︎🅔︎🅢︎");
    ChannelModel eightChannel = ChannelModel(channelName: "EDAVANNA TIMES",channelLink: "https://chat.whatsapp.com/JmiDGk5Y1FLFbp1QX4JTY5",specialName: "Ⓔⓓⓐⓥⓐⓝⓝⓐ ⓣⓘⓜⓔⓢ");
    ChannelModel nineChannel = ChannelModel(channelName: "കാലിക്കറ്റ്‌ news",channelLink: "https://chat.whatsapp.com/Jt3xk68HBcF2YmHc1apStg",specialName: "🄲🄰🄻🄸🄲🅄🅃 🄽🄴🅆🅂");

    List<ChannelModel> channels = [firstChannel,secondChannel,thirdChannel,fourthChannel,fiveChannel,sixthChannel,sevenChannel,eightChannel,nineChannel];
    return await handler.insertChannels(channels);
  }
}
