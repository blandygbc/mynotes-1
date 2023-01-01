import 'package:flutter/material.dart';
import 'package:mynotes/config/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/view/auth/login_view.dart';
import 'package:mynotes/view/auth/register_view.dart';

class VerifyEmailView extends StatefulWidget {
  static String routeName = '/email-verify';

  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    NavigatorState navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify your email'),
      ),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
            '''We've sent you an email verification. Please open it to verify your account.
            \nIf you haven't received a verification email yet, press the button below.'''),
        TextButton(
          child: const Text('Send email verification'),
          onPressed: () async {
            await AuthService.firebase().sendEmailVerification();
          },
        ),
        TextButton(
          child: const Text('Restart'),
          onPressed: () async {
            await AuthService.firebase().logOut();
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: routes[RegisterView.routeName]!),
              (route) => false,
            );
          },
        ),
        TextButton(
          child: const Text('Go back to login'),
          onPressed: () {
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: routes[LoginView.routeName]!),
              (route) => false,
            );
          },
        ),
      ]),
    );
  }
}