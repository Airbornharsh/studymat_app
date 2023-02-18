import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studymat_app/providers/Settings.dart';
import 'package:studymat_app/providers/StudyMats.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = "videoscreen";
  VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    final mat = ModalRoute.of(context)!.settings.arguments as Mat;

    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(mat.link) as String,
        flags: const YoutubePlayerFlags(
            autoPlay: false, controlsVisibleAtStart: true));

    return Scaffold(
      appBar: Orientation.portrait == MediaQuery.of(context).orientation
          ? AppBar(title: Text(mat.name))
          : null,
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () => debugPrint("Ready"),
        aspectRatio: Orientation.landscape == MediaQuery.of(context).orientation
            ? MediaQuery.of(context).size.width /
                MediaQuery.of(context).size.height
            : 16 / 9,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
                playedColor: Provider.of<Settings>(context).getPrimary,
                handleColor: Provider.of<Settings>(context).getColor1),
          ),
          const PlaybackSpeedButton(),
          FullScreenButton()
        ],
      ),
    );
  }
}
