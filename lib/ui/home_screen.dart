import 'package:flutter_video_stream_tiktok_clone/core/mock/video.dart';


import 'package:flutter_video_stream_tiktok_clone/ui/page/follow_page.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/page/message_page.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/page/search_page.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/page/user_page.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/screens/camera_screen.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/screens/comment_bottom_sheet.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/screens/tick_tock_scaffold.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/screens/tick_tock_video.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/screens/tiktok_like_video_button_column.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/screens/widgets/header_widget.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/screens/widgets/tick_tock_tab_bar.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/tick_tock_video_player.dart';
import 'package:safemap/safemap.dart';




// Modified the height of the bottomSheet component separately
import 'package:flutter_video_stream_tiktok_clone/ui/screens/widgets/bottom_sheet.dart' as CustomBottomSheet;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  TikTokPageTag tabBarType = TikTokPageTag.home;

  TikTokScaffoldController tkController = TikTokScaffoldController();

  PageController _pageController = PageController();

  VideoListController _videoListController = VideoListController();

  // Record likes

  Map<int, bool> favoriteMap = {};

  List<UserVideo> videoDataList = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) {
      _videoListController.currentPlayer.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoListController.currentPlayer.pause();
    super.dispose();
  }

  @override
  void initState() {
    videoDataList = UserVideo.fetchVideo();
    WidgetsBinding.instance.addObserver(this);
    _videoListController.init(
      _pageController,
      videoDataList,
    );
    tkController.addListener(
      () {
        if (tkController.value == TikTokPagePositon.middle) {
          _videoListController.currentPlayer.start();
        } else {
          _videoListController.currentPlayer.pause();
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    switch (tabBarType) {
      case TikTokPageTag.home:
        break;
      case TikTokPageTag.follow:
        currentPage = FollowPage();
        break;
      case TikTokPageTag.msg:
        currentPage = MsgPage();
        break;
      case TikTokPageTag.me:
        currentPage = UserPage(isSelfPage: true);
        break;
    }
    double a = MediaQuery.of(context).size.aspectRatio;
    bool hasBottomPadding = a < 0.55;

    bool hasBackground = hasBottomPadding;
    hasBackground = tabBarType != TikTokPageTag.home;
    if (hasBottomPadding) {
      hasBackground = true;
    }
    Widget tikTokTabBar = TikTokTabBar(
      hasBackground: hasBackground,
      current: tabBarType,
      onTabSwitch: (type) async {
        setState(() {
          tabBarType = type;
          if (type == TikTokPageTag.home) {
            _videoListController.currentPlayer.start();
          } else {
            _videoListController.currentPlayer.pause();
          }
        });
      },
      onAddButton: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => CameraPage(),
          ),
        );
      },
    );

    var userPage = UserPage(
      isSelfPage: false,
      canPop: true,
      onPop: () {
        tkController.animateToMiddle();
      },
    );
    var searchPage = SearchPage(
      onPop: tkController.animateToMiddle,
    );

    var header = tabBarType == TikTokPageTag.home
        ? TikTokHeader(
            onSearch: () {
              tkController.animateToLeft();
            },
          )
        : Container();

    // Combination
    return TikTokScaffold(
      controller: tkController,
      hasBottomPadding: hasBackground,
      tabBar: tikTokTabBar,
      header: header,
      leftPage: searchPage,
      rightPage: userPage,
      enableGesture: tabBarType == TikTokPageTag.home,
      // onPullDownRefresh: _fetchData,
      page: Stack(
        // index: currentPage == null ? 0 : 1,
        children: <Widget>[
          PageView.builder(
            key: Key('home'),
            controller: _pageController,
            pageSnapping: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _videoListController.videoCount,
            itemBuilder: (context, i) {
              
            // Put together a video component
              var data = videoDataList[i];
              bool isF = SafeMap(favoriteMap)[i].boolean ?? false;
              var player = _videoListController.playerOfIndex(i);
              // Right button bar
              Widget buttons = TikTokButtonColumn(
                isFavorite: isF,
                onAvatar: () {
                  tkController.animateToPage(TikTokPagePositon.right);
                },
                onFavorite: () {
                  setState(() {
                    favoriteMap[i] = !isF;
                  });
                  // showAboutDialog(context: context);
                },
                onComment: () {
                  CustomBottomSheet.showModalBottomSheet(
                    backgroundColor: Colors.white.withOpacity(0),
                    context: context,
                    builder: (BuildContext context) =>
                        TikTokCommentBottomSheet(),
                  );
                },
                onShare: () {},
              );
              // video
              Widget currentVideo = Center(
                child: FijkView(
                  fit: FijkFit.fitHeight,
                  player: player,
                  color: Colors.black,
                  panelBuilder: (_, __, ___, ____, _____) => Container(),
                ),
              );

              currentVideo = TikTokVideoPage(
                hidePauseIcon: player.state != FijkState.paused,
                aspectRatio: 9 / 16.0,
                key: Key(data.url + '$i'),
                tag: data.url,
                bottomPadding: hasBottomPadding ? 16.0 : 16.0,
                userInfoWidget: VideoUserInfo(
                  desc: data.desc,
                  bottomPadding: hasBottomPadding ? 16.0 : 50.0,
                  // onGoodGift: () => showDialog(
                  //   context: context,
                  //   builder: (_) => FreeGiftDialog(),
                  // ),
                ),
                onSingleTap: () async {
                  if (player.state == FijkState.started) {
                    await player.pause();
                  } else {
                    await player.start();
                  }
                  setState(() {});
                },
                onAddFavorite: () {
                  setState(() {
                    favoriteMap[i] = true;
                  });
                },
                rightButtonColumn: buttons,
                video: currentVideo,
              );
              return currentVideo;
            },
          ),
          Opacity(
            opacity: 1,
            child: currentPage ?? Container(),
          ),
          // Center(
          //   child: Text(_currentIndex.toString()),
          // )
        ],
      ),
    );
  }
}
