import 'package:flutter/material.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/page/message_detail_list_page.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/screens/tick_tock_top_ap_bar.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/screens/user_message_row.dart';
import 'package:flutter_video_stream_tiktok_clone/ui/utility/styles/style.dart';
import 'package:tapped/tapped.dart';

class MsgPage extends StatefulWidget {
  @override
  _MsgPageState createState() => _MsgPageState();
}

class _MsgPageState extends State<MsgPage> {
  int select = 0;
  @override
  Widget build(BuildContext context) {
    Widget head = TikTokSwitchAppbar(
      index: select,
      list: ['news'],
      onSwitch: (i) => setState(() => select = i),
    );
    Widget topButtons = Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _TopIconTextButton(
            title: 'Fans',
            icon: Icons.person,
            color: Colors.indigo,
            color2: Colors.green,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (cxt) => MsgDetailListPage(
                    title: 'fans',
                    msgTitle: 'Your fans',
                    msgDesc: 'I am your fan',
                  ),
                ),
              );
            },
          ),
          _TopIconTextButton(
            title: 'great',
            icon: Icons.golf_course,
            color: Colors.teal,
            color2: Colors.blue,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (cxt) => MsgDetailListPage(
                    title: 'great',
                    msgTitle: 'Your fans',
                    msgDesc: 'Gave you a like',
                  ),
                ),
              );
            },
          ),
          _TopIconTextButton(
            title: '@',
            icon: Icons.people,
            color: Colors.deepPurple,
            color2: Colors.pink,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (cxt) => MsgDetailListPage(
                    title: '@',
                    msgTitle: 'Your fans',
                    msgDesc: 'Mike mentioned you',
                    reverse: true,
                  ),
                ),
              );
            },
          ),
          _TopIconTextButton(
            title: 'comment',
            icon: Icons.mode_comment,
            color: Colors.red,
            color2: Colors.amber,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (cxt) => MsgDetailListPage(
                    title: 'comment',
                    msgTitle: 'Double clicked',
                    msgDesc: 'Your fans',
                    reverse: true,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
    Widget ad = Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: AspectRatio(
        aspectRatio: 4.0,
        child: Container(
          decoration: BoxDecoration(
            color: ColorPlate.darkGray,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            'Reserved',
            style: TextStyle(
              color: Colors.white.withOpacity(0.1),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
    Widget body = Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: <Widget>[
          topButtons,
          ad,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'system ..',
              style: StandardTextStyle.smallWithOpacity,
            ),
          ),
          UserMsgRow(
            lead: ClipOval(
              child: Container(
                color: ColorPlate.back2,
                child: Icon(
                  Icons.done_all,
                  color: ColorPlate.orange,
                ),
              ),
            ),
            title: 'meeting..',
            desc: 'You have 3 negotions pending',
          ),
          UserMsgRow(
            lead: ClipOval(
              child: Container(
                color: ColorPlate.back2,
                child: Icon(
                  Icons.business,
                  color: ColorPlate.orange,
                ),
              ),
            ),
            title: 'system',
            desc: '12 Unread messages',
          ),
          UserMsgRow(
            lead: ClipOval(
              child: Container(
                color: ColorPlate.back2,
                child: Icon(
                  Icons.business,
                  color: ColorPlate.orange,
                ),
              ),
            ),
            title: 'Notice',
            desc: '98 Unread notifications',
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Private message',
              style: StandardTextStyle.smallWithOpacity,
            ),
          ),
          UserMsgRow(),
          UserMsgRow(),
          UserMsgRow(),
          UserMsgRow(),
          UserMsgRow(),
          UserMsgRow(),
        ],
      ),
    );
    body = Container(
      color: ColorPlate.back1,
      child: Column(
        children: <Widget>[
          head,
          body,
        ],
      ),
    );
    return body;
  }
}

class _TopIconTextButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color color2;
  final String title;
  final Function onTap;

  const _TopIconTextButton({
    Key key,
    this.icon,
    this.color,
    this.title,
    this.color2: Colors.white,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var iconContainer = Container(
      margin: EdgeInsets.all(6),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            color2,
            color,
          ],
          stops: [0.1, 0.8],
        ),
      ),
      child: Icon(
        icon,
      ),
    );
    Widget body = Column(
      children: <Widget>[
        iconContainer,
        Text(
          title,
          style: StandardTextStyle.small,
        )
      ],
    );
    body = Tapped(
      child: body,
      onTap: onTap,
    );
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: body,
      ),
    );
  }
}
