import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/features/tweet/views/create_tweet_view.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final appBar = UIConstants.appBar();
  int _page = 0;
  void onChangePage(int index) {
    setState(() {
      _page = index;
    });
  }

  void onCreateTweet() {
    Navigator.push(
      context,
      CreateTweetScreen.route(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _page,
        children: UIConstants.bottomTabBarView,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.blueColor,
        onPressed: onCreateTweet,
        child: const Icon(
          Icons.add,
          color: Palette.whiteColor,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onChangePage,
        backgroundColor: Palette.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 0
                  ? AssetsConstants.homeFilledIcon
                  : AssetsConstants.homeOutlinedIcon,
              colorFilter:
                  const ColorFilter.mode(Palette.whiteColor, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              colorFilter:
                  const ColorFilter.mode(Palette.whiteColor, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 2
                  ? AssetsConstants.notifFilledIcon
                  : AssetsConstants.notifOutlinedIcon,
              colorFilter:
                  const ColorFilter.mode(Palette.whiteColor, BlendMode.srcIn),
            ),
          )
        ],
      ),
    );
  }
}
