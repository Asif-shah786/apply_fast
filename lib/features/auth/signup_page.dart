


import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/widgets/content_view.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../widgets/page_header.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    return ContentView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PageHeader(
            title: 'Sign Up',
            description: 'Register yourself to keep your data saved',
          ),
          const Gap(16),
          ElevatedButton(onPressed: (){}, child: Text('Sign Up')),
          ElevatedButton(onPressed: (){}, child: Text('Sign Up'))

        ],
      ),
    );
  }
}
