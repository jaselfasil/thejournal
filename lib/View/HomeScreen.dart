import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thejournal/Model/ChannelModel.dart';
import 'package:thejournal/View/consolidateScreen.dart';
import '../Controller/homeController.dart';
import '../DatabaseHelper.dart';
import '../utils/colors.dart';
import 'addChannel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController headerController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  late DbHelper handler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = DbHelper();
    /* handler.initDb().whenComplete(() async {
      channels = await handler.retrieveChannels();
      setState(() {});
    });*/
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    HomeProvider homeViewModel = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(fontSize: width * 0.06),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddChannel(homeViewModel.channels[0], false)))
                  .then((value) {
                homeViewModel.fetchChannels();
              });
            },
          )
        ],
      ),
      body: ListView(
        children: [
          getHeaderWidget(width, height),
          getContentWidget(width, height),
          getList(context, width, height)
        ],
      ),
    );
  }

  Widget getHeaderWidget(double width, double height) {
    return Container(
      margin: EdgeInsets.all(15),
      child: TextFormField(
        controller: headerController,
        style: TextStyle(
          fontSize: width * 0.035,
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

          hintText: "Header",

          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: width * 0.035,
          ),

          //create lable
          labelText: 'Header',
          //lable style
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: width * 0.035,
          ),
        ),
      ),
    );
  }

  Widget getContentWidget(double width, double height) {
    return Container(
      margin: EdgeInsets.all(15),
      child: TextFormField(
        maxLines: 6,
        controller: contentController,
        style: TextStyle(
          fontSize: width * 0.035,
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

          hintText: "Content",

          //make hint text
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: width * 0.035,
          ),

          //create lable
          labelText: 'Content',
          //lable style
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: width * 0.035,
          ),
        ),
      ),
    );
  }

  Widget getList(BuildContext context, double width, double height) {
    HomeProvider homeViewModel = context.watch<HomeProvider>();
    return Padding(
      padding:  EdgeInsets.only(bottom: width * 0.035),
      child: Column(
        children: [
          Consumer<HomeProvider>(builder: (context, viewModel, child) {
            return ListView.builder(
                itemCount: homeViewModel.channels.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var item = homeViewModel.channels[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.035, right: width * 0.035),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConsolidateScreen(
                                        item,
                                        headerController.text.toString(),
                                        contentController.text.toString())))
                            .then((value) {
                          homeViewModel.fetchChannels();
                        });
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      item.channelName.toString(),
                                      style: TextStyle(fontSize: width * 0.035),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddChannel(item, true)))
                                            .then((value) {
                                          homeViewModel.fetchChannels();
                                        });
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false, // user must tap button for close dialog!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Delete This Channel?'),
                                            content: const Text(
                                                'This will delete the channel from your device.'),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                child: const Text('Cancel'),
                                                onPressed: () {

                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              ElevatedButton(
                                                child: const Text('Delete'),
                                                onPressed: () async{
                                                  await handler
                                                      .deleteChannel(item.channelId!)
                                                      .then((value) {
                                                    homeViewModel.fetchChannels();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                      /*await handler
                                          .deleteChannel(item.channelId!)
                                          .then((value) {
                                        homeViewModel.fetchChannels();
                                      });*/
                                    },
                                    child: Text(
                                      "Remove",
                                      style: TextStyle(
                                          fontSize: width * 0.032,
                                          color: MyColor.tabblack,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          })
        ],
      ),
    );
  }
}
