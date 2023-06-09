
class ChannelModel{
  int? channelId;
  String? channelName;
  String? channelLink;
  String? specialName;
  ChannelModel(
      {this.channelId, this.channelName, this.channelLink, this.specialName});
  ChannelModel.fromJsonDBforDetails(Map<String, dynamic> json) {
    channelId = json['channel_id'];
    channelName = json['channel_name'];
    channelLink = json['channel_link'];
    specialName = json["special_name"];
  }
  Map<String, dynamic> toJsonDB() {
    /*final Map<String, dynamic> ChannelModel = new Map<String, dynamic>();
    ChannelModel["channel_id"] = this.channelId;
    ChannelModel["channel_name"] = this.channelName;
    ChannelModel["special_name"] = this.specialName;
    ChannelModel["channel_link"] = this.channelLink;
    return ChannelModel;*/
    return {
     /* 'channel_id': channelId,*/
      'channel_name': channelName,
      'special_name': specialName,
      'channel_link': channelLink
    };
  }

}