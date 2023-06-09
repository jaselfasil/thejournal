import 'package:flutter/material.dart';

import '../DatabaseHelper.dart';
import '../Model/ChannelModel.dart';

class HomeProvider with ChangeNotifier {

 var handler = DbHelper();
  List<ChannelModel> channels = [];
  HomeProvider() {
    fetchChannels();
  }
 fetchChannels() async {
      channels = await handler.retrieveChannels();
      print("calling");
      notifyListeners();
  }


}