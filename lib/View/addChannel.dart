import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thejournal/Controller/homeController.dart';

import '../DatabaseHelper.dart';
import '../Model/ChannelModel.dart';

class AddChannel extends StatefulWidget {
  ChannelModel channelModel;
  bool isEdit;

  AddChannel(this.channelModel, this.isEdit);

  @override
  State<AddChannel> createState() => AddChannelState();
}

class AddChannelState extends State<AddChannel> {
  TextEditingController channelName = TextEditingController();
  TextEditingController channelLink = TextEditingController();
  TextEditingController specialName = TextEditingController();

  late DbHelper handler;
  int? channelId;
  HomeProvider homeProvider = HomeProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = DbHelper();
    channelId = widget.channelModel.channelId == null
        ? 0
        : widget.isEdit == false
            ? 0
            : widget.channelModel.channelId;
    print("THe channel id is" + channelId.toString());
    channelName.text = widget.channelModel.channelName == ""
        ? ""
        : widget.isEdit == false
            ? ""
            : widget.channelModel.channelName.toString();
    specialName.text = widget.channelModel.specialName == ""
        ? ""
        : widget.isEdit == false
            ? ""
            : widget.channelModel.specialName.toString();
    channelLink.text = widget.channelModel.channelLink == ""
        ? ""
        : widget.isEdit == false
            ? ""
            : widget.channelModel.channelLink.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit == true ? "Edit Channel" : "Add Channel"),
      ),
      body: ListView(
        children: [
          getChannelNameWidget(),
          getSpecialNameWidget(),
          getChannelLinkWidget(),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  //    onShare();
                  createChannel(context).then((value){
                    Navigator.pop(context,"ab");
                  });
                },
                child: Text(
                  widget.isEdit == true ? "UPDATE" : 'ADD',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getChannelNameWidget() {
    return Container(
      margin: EdgeInsets.all(15),
      child: TextFormField(
        controller: channelName,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          //fontWeight: FontWeight.w600,
        ),
        /*onChanged: (value) {
          setState(() {
            userInput.text = value.toString();
          });
        },*/
        decoration: InputDecoration(
          focusColor: Colors.white,

          /*errorText: "Error",*/

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey,

          hintText: "ChannelName",

          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),

          //create lable
          labelText: 'Channel Name',
          //lable style
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget getSpecialNameWidget() {
    return Container(
      margin: EdgeInsets.all(15),
      child: TextFormField(
        controller: specialName,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          //fontWeight: FontWeight.w600,
        ),
        /*onChanged: (value) {
          setState(() {
            userInput.text = value.toString();
          });
        },*/
        decoration: InputDecoration(
          focusColor: Colors.white,

          /*errorText: "Error",*/

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey,

          hintText: "Special Name",

          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),

          //create lable
          labelText: 'Special Name',
          //lable style
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget getChannelLinkWidget() {
    return Container(
      margin: EdgeInsets.all(15),
      child: TextFormField(
        controller: channelLink,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          //fontWeight: FontWeight.w600,
        ),
        /*onChanged: (value) {
          setState(() {
            userInput.text = value.toString();
          });
        },*/
        decoration: InputDecoration(
          focusColor: Colors.white,

          /*errorText: "Error",*/

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey,

          hintText: "Channel Link",

          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),

          //create lable
          labelText: 'Channel Link',
          //lable style
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

 Future<dynamic> createChannel(BuildContext context) async {
    if (widget.isEdit == true) {
      // await handler.deleteChannel(channelId!);
      ChannelModel channelModel = ChannelModel(
        channelId: widget.channelModel.channelId,
          channelName: channelName.text,
          specialName: specialName.text,
          channelLink: channelLink.text);
      // ChannelModel channels = channelModel;
      return await handler.updateChannels(channelModel);
    } else {
      ChannelModel channelModel =
          ChannelModel(channelName:channelName.text, channelLink:channelLink.text,specialName: specialName.text);
      List<ChannelModel> channels = [channelModel];
      return await handler.insertChannels(channels);
    }
  }
}
