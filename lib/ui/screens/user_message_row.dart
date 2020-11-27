import 'package:flutter/material.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/utility/styles/style.dart';
import 'package:tapped/tapped.dart';

class UserMsgRow extends StatelessWidget {
  final Widget lead;
  final String title;
  final String desc;
  final bool reverse;
  const UserMsgRow({
    Key key,
    this.title,
    this.desc,
    this.reverse: false,
    this.lead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      Text(
        title ?? 'user',
        style: StandardTextStyle.normalW,
      ),
      Container(height: 2),
      Text(
        desc ?? 'Say hello to you',
        style: StandardTextStyle.smallWithOpacity,
      ),
    ];
    var info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: reverse ? list.reversed.toList() : list,
    );
    var right = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '10-12',
          style: StandardTextStyle.smallWithOpacity,
        ),
      ],
    );
    var avatar = Container(
      margin: EdgeInsets.fromLTRB(0, 8, 10, 8),
      child: Container(
        height: 40,
        width: 40,
        child: lead ??
            ClipOval(
              child: Image.network(
                "https://media.giphy.com/media/4HkkcZv2r5yCkkBDid/giphy.gif",fit: BoxFit.cover,
              ),
            ),
      ),
    );
    return Tapped(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: <Widget>[
            avatar,
            Expanded(child: info),
            right,
          ],
        ),
      ),
    );
  }
}
