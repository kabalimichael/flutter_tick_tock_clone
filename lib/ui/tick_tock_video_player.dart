
import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter_video_stream_tiktok_clone/core/mock/video.dart';

// class VideoInfo {
//   final String url;
//   final String title;

//   VideoInfo(this.url, this.title);
// }

class VideoListController {
  /// Construction
  VideoListController();

  /// 
// Snap to slide to realize page turning
  void setPageContrller(PageController pageController) {
    pageController.addListener(() {
      var p = pageController.page;
      if (p % 1 == 0) {
        int target = p ~/ 1;
        if (index.value == target) return;
        // 
// Play the current one, pause the others
        var oldIndex = index.value;
        var newIndex = target;
        playerOfIndex(oldIndex).seekTo(0);
        playerOfIndex(oldIndex).pause();
        playerOfIndex(newIndex).start();
        // Carry out
        index.value = target;
      }
    });
  }

  /// 
// Get the player with the specified index
  FijkPlayer playerOfIndex(int index) => playerList[index];

  
// Total number of videos
  int get videoCount => playerList.length;

  //
// Continue to add videos behind the current list and preload the cover
  addVideoInfo(List<UserVideo> list) {
    for (var info in list) {
      playerList.add(
        FijkPlayer()
          ..setDataSource(
            info.url,
            autoPlay: playerList.length == 0,
            showCover: true,
          )
          ..setLoop(0),
      );
    }
  }

  /// Initializing
  init(PageController pageController, List<UserVideo> initialList) {
    addVideoInfo(initialList);
    setPageContrller(pageController);
  }

  // 
// Current video sequence number
  ValueNotifier<int> index = ValueNotifier<int>(0);

  /// Video list
  List<FijkPlayer> playerList = [];

  ///
  FijkPlayer get currentPlayer => playerList[index.value];

  bool get isPlaying => currentPlayer.state == FijkState.started;

  /// Destroy all
  void dispose() {
    // Destroy all
    for (var player in playerList) {
      player.dispose();
    }
    playerList = [];
  }
}
