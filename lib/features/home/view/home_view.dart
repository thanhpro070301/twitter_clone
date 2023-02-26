import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );

  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
        body: Center(
      child: Text(
        "W E L C O M E TWITTER",
        style: TextStyle(fontSize: 30),
      ),
    ));
  }
}
