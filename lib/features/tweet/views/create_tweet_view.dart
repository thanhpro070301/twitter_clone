import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/controller/auth_controller.dart';
import 'package:twitter_clone/theme/theme.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const CreateTweetScreen(),
      );
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  @override
  Widget build(BuildContext context) {
    final currenUser = ref.watch(currenUserDetailProvider).value;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.close),
        actions: [
          RoundedSmallButton(
            onTap: () {
              // print(currenUser?.uid);
              print(ref.watch(idpr));
            },
            label: "Tweet",
            backgroundColor: Palette.blueColor,
            textColor: Palette.whiteColor,
          ),
        ],
      ),
      body: currenUser == null
          ? const Loader()
          : SafeArea(
              child: Column(children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(currenUser.profilePic),
                  )
                ],
              )
            ])),
    );
  }
}
