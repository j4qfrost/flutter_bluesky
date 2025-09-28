import 'package:flutter/material.dart';
import 'package:flutter_bluesky/api/model/actor.dart';
import 'package:flutter_bluesky/screen/parts/adjuser.dart';
import 'package:flutter_bluesky/screen/parts/image/avatar.dart';
import 'package:flutter_bluesky/screen/parts/button.dart';
import 'package:flutter_bluesky/screen/parts/button/button_manager.dart';
import 'package:flutter_bluesky/screen/parts/timeline/common.dart';
import 'package:flutter_bluesky/screen/profile.dart';
import 'package:flutter_bluesky/util/account_util.dart';
import 'package:tuple/tuple.dart';

ActorContent? customActorContent;

class ActorLine extends StatefulWidget {
  final ProfileView actor;
  const ActorLine({super.key, required this.actor});
  @override
  ActorLineScreen createState() => ActorLineScreen();
}

class ActorLineScreen extends State<ActorLine> {
  @override
  Widget build(BuildContext context) {
    return padding10(paddingLR([
      Avatar(context).net(widget.actor).profile
    ], [
      content,
    ]));
  }

  Widget get content {
    ActorContent ac = customActorContent ?? ActorContent();
    return ac.build(this, widget.actor);
  }
}

class ActorContent {
  Widget build(State state, ProfileView actor) {
    FollowButton button = followButton(state, actor);
    Widget left = displayNameHandle(actor);
    Widget right = widget(button, actor);
    Widget transfer = Profile(actor: actor.did);
    return inkWell(state, actor, left, right, transfer);
  }

  FollowButton followButton(State state, ProfileView actor) {
    return buttonManager!.followButton(state, actor) as FollowButton;
  }

  Widget widget(FollowButton button, ProfileView actor) {
    if (isLoginUser(actor)) {
      return const Center();
    } else {
      return button.widget;
    }
  }

  Widget inkWell(State state, ProfileView actor, Widget left, Widget right,
      Widget transfer) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lr(left, right, const Tuple2(5, 4)),
          description(actor, state.context),
        ],
      ),
      onTap: () async {
        Navigator.push(
          state.context,
          MaterialPageRoute(builder: (context) => transfer),
        );
      },
    );
  }
}
