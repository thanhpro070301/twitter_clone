import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/theme/theme.dart';
import 'assets_constants.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        colorFilter: const ColorFilter.mode(Palette.blueColor, BlendMode.srcIn),
        height: 30,
      ),
      centerTitle: true,
    );
  }
}
