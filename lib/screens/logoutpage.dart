// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_project/screens/login_page.dart';
// import 'package:path_provider/path_provider.dart';

// class LogoutDialog {
//   static void show(BuildContext context) {
//     showDialog(
//       context: context,
//       builder:
//           (ctx) => AlertDialog(
//             title: const Text('Confirm Logout'),
//             content: const Text('Are you sure you want to log out?'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop(); // ❌ Cancel logout
//                 },
//                 child: const Text('No'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Hive.box('UsersBox').clear(); // Clear the Hive box
//                   Navigator.pushNamedAndRemoveUntil(
//                     context,
//                     '/login', // Navigate to the login page
//                     (route) => false, // Remove all previous routes
//                   );
//                 },
//                 child: const Text('Yes'),
//               ),
//             ],
//           ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(); // ❌ Cancel logout
                },
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Hive.box('sessionBox').put('isLoggedIn', false);
                  Hive.box('sessionBox').delete('currentUserEmail');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  }
}
