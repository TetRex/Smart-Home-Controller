import 'package:flutter/material.dart';
import 'package:mjpeg_stream/mjpeg_stream.dart';

class CameraPlayer extends StatefulWidget {
  const CameraPlayer({super.key});

  @override
  State<CameraPlayer> createState() => _MainAppState();
}

class _MainAppState extends State<CameraPlayer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 500,
      width: screenWidth,
      decoration: BoxDecoration(
        color: const Color.fromARGB(88, 76, 175, 79),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        child: MJPEGStreamScreen(
          streamUrl: "http://204.106.237.68:88/mjpg/1/video.mjpg",
          showLiveIcon: true,
        ),
      ),
    );
  }
}
