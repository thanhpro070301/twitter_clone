import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/controller/auth_controller.dart';
import 'package:twitter_clone/theme/theme.dart';

import 'features/home/view/home_view.dart';
import 'features/view/sign_up_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      title: 'Twitter Demo',
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              }
              return const SignUpView();
            },
            error: (err, st) {
              return ErrorPage(
                errorText: err.toString(),
              );
            },
            loading: () => const LoadingPage(),
          ),
    );
  }
}
