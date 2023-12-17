


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/widgets/content_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../widgets/page_header.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ResponsiveBreakpoints.of(context);
    return ContentView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PageHeader(
            title: 'Login',
            description: 'Register yourself to keep your data saved',
          ),
          const Gap(16),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signInAnonymously();
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
