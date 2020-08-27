import 'package:flutter/material.dart';
import 'package:xz_youtube_t/models/channel_model.dart';
import 'package:xz_youtube_t/models/video_model.dart';
import 'package:xz_youtube_t/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UC6Dy0rQ6zDnQuHQ1EeErGUA');
    setState(() {
      _channel = channel;
    });
  }

  Widget _buildVideo(Video video) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("youtube channel")),
        body: _channel != null
            ? ListView.builder(
                itemCount: _channel.videos.length,
                itemBuilder: (context, index) {
                  Video video = _channel.videos[index];
                  return _buildVideo(video);
                })
            : Center(child: CircularProgressIndicator()));
  }
}
