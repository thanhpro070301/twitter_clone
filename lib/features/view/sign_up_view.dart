import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/common.dart';
import '../../constants/constants.dart';
import '../../theme/theme.dart';
import '../controller/controller.dart';
import '../widgets/auth_field.dart';
import 'login_view.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      //Text Field 1
                      AuthField(controller: emailController, hinText: 'Email'),
                      const SizedBox(height: 20),
                      //Text Field 2
                      AuthField(
                          controller: passwordController, hinText: 'Password'),
                      const SizedBox(height: 40),
                      //Button
                      Align(
                        alignment: Alignment.topRight,
                        child:
                            RoundedSmallButton(onTap: onSignUp, label: 'Done'),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(color: Palette.greyColor),
                          children: [
                            TextSpan(
                              text: "Login",
                              style: const TextStyle(color: Palette.blueColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, LoginView.route());
                                },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
