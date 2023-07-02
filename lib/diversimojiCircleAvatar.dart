import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'diversimojiController.dart';

/// This widget renders the Diversimoji of the user on screen
///
/// Accepts a [radius] which defaults to 75.0
/// and a [backgroundColor] which defaults to blueAccent
///
/// Advice the users to set up their Diversimoji first to avoid unexpected issues.
class DiversimojiCircleAvatar extends StatelessWidget {
  final double radius;
  final Color? backgroundColor;
  DiversimojiCircleAvatar({Key? key, this.radius = 75.0, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (backgroundColor == null)
      CircleAvatar(radius: radius, child: buildGetX());
    return CircleAvatar(
        radius: radius, backgroundColor: backgroundColor, child: buildGetX());
  }

  GetX<DiversimojiController> buildGetX() {
    return GetX<DiversimojiController>(
        init: DiversimojiController(),
        autoRemove: false,
        builder: (snapshot) {
          if (snapshot.diversimoji.value.isEmpty) {
            return CupertinoActivityIndicator();
          }
          return SvgPicture.string(
            snapshot.diversimoji.value,
            height: radius * 1.6,
            semanticsLabel: "Your Diversimoji",
            placeholderBuilder: (context) => Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        });
  }
}
