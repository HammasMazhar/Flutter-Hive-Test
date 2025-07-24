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
                  Navigator.of(ctx).pop();
                },
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Hive.box('sessionBox').put('isLoggedIn', false);
                  //    Hive.box('sessionBox').delete('currentUserEmail');
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  }
}
