import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thejournal/Model/ChannelModel.dart';

class ConsolidateScreen extends StatefulWidget {
//  const ConsolidateScreen({Key? key}) : super(key: key);
  ChannelModel channelModel;
  String header, content;

  ConsolidateScreen(this.channelModel, this.header, this.content);

  @override
  State<ConsolidateScreen> createState() => _ConsolidateScreenState();
}

class _ConsolidateScreenState extends State<ConsolidateScreen> {
  String data = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = "*${widget.channelModel.channelName}*\n" +
        "${currentDateTime()}\n\n" +
        "${widget.header}\n\n" +
        "${widget.channelModel.specialName}\n${widget.channelModel.channelLink}\n${widget.channelModel.specialName}\n\n" +
        "${widget.content}\n" +
        "🔰🔰🔰🔰🔰🔰🔰🔰🔰\n${widget.channelModel.specialName}\n\n🅙🅞🅘🅝 🅝🅞🅦\n*${widget.channelModel.channelName}*\n\n${widget.channelModel.channelLink}\n\n" +
        "വാർത്തകളും പരസ്യങ്ങളും നൽകാൻ 👇🏼👇🏼\n\nhttp://Wa.me/+918921084080\n\nᴠɪꜱɪᴛ:\nhttp://www.thejournalnews.in";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Content"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              data,
              style: TextStyle(color: Colors.black),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () async {
                        await Clipboard.setData(
                            ClipboardData(text: data));
                        // copied successfully
                      },
                      child: Text(
                        'COPY',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        onShare();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'SHARE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onShare() {
    /* var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
    var imageId = await ImageDownloader.downloadImage(
        fishSpecie.speciesIllustrationPhoto!.src!);
    if (imageId == null) {
      return;
    }*/
    /* var path = await ImageDownloader.findPath(imageId);*/
    Share.share(data);
  }

  String currentDateTime() {
    DateFormat dateFormat = new DateFormat("dd-MM-yyyy");
    var now = new DateTime.now();
    return (dateFormat.format(now));
  }
}
