import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'login_page.dart'; // ✅ For navigation after successful registration

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  static const routename = '/signup'; // ✅ Route name (optional usage)
  bool isChecked = false; // ✅ Checkbox state for terms & conditions

  // ✅ Text controllers for input fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // ✅ Password validation (min 8 chars, upper, lower, digit, special char)
  bool isPasswordStrong(String password) {
    RegExp pattern = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\\$&*~]).{8,}$',
    );
    return pattern.hasMatch(password);
  }

  // ✅ Snackbar to show messages
  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // ✅ Main registration function
  void registerUser() {
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // ✅ Email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email) || !email.endsWith('@gmail.com')) {
      showMessage("Enter a valid Gmail address");
      return;
    }

    // ✅ Check password strength
    if (!isPasswordStrong(password)) {
      showMessage(
        "Password must be at least 8 characters long, and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.",
      );
      return;
    }

    // ✅ Check all fields
    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty) {
      showMessage("Please fill in all fields");
      return;
    }

    // ✅ Check if checkbox is ticked
    if (!isChecked) {
      showMessage("You must agree to the terms and policy");
      return;
    }

    // ✅ Confirm password match
    if (password != confirmPassword) {
      showMessage("Passwords do not match");
      return;
    }

    // ✅ Check if user exists in Hive
    var box = Hive.box('usersBox');
    if (box.containsKey(email)) {
      showMessage("User already exists");
      return;
    }

    // ✅ Save new user
    box.put(email, password);

    // ✅ Success message and navigate to login
    showMessage("User registered successfully");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B30),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // ✅ Name fields
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextField(
                      controller: _firstNameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black26,
                        labelText: 'First Name',
                        hintText: 'Enter First Name',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white54),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.lightBlue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextField(
                      controller: _lastNameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black26,
                        labelText: 'Last Name',
                        hintText: 'Enter Last Name',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white54),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.lightBlue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // ✅ Email
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black26,
                labelText: 'Email',
                hintText: 'Enter your Email',
                labelStyle: const TextStyle(color: Colors.white),
                hintStyle: const TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blueAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.lightBlue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // ✅ Password
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black26,
                labelText: 'Password',
                hintText: 'Use Lower,Digit & Special Char(8+ chars)',
                labelStyle: const TextStyle(color: Colors.white),
                hintStyle: const TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blueAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.lightBlue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Confirm Password
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black26,
                labelText: 'Confirm password',
                hintText: 'Re-enter your Password',
                labelStyle: const TextStyle(color: Colors.white),
                hintStyle: const TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blueAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.lightBlue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Terms checkbox
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isChecked ? Colors.green : Colors.white,
                        width: 2,
                      ),
                      color: isChecked ? Colors.green : Colors.transparent,
                    ),
                    child:
                        isChecked
                            ? const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.white,
                            )
                            : null,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Agree with our terms and policy',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // ✅ Sign Up button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C13FF),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Already registered
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// // ✅ NO DESIGN CHANGES – ONLY ADDED USER SAVE LOGIC AS MAP
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'login_page.dart'; // ✅ For navigation after successful registration

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   static const routename = '/signup';
//   bool isChecked = false;

//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool isPasswordStrong(String password) {
//     RegExp pattern = RegExp(
//       r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\\$&*~]).{8,}$',
//     );
//     return pattern.hasMatch(password);
//   }

//   void showMessage(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   void registerUser() {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text;
//     String confirmPassword = _confirmPasswordController.text;
//     String firstName = _firstNameController.text.trim();
//     String lastName = _lastNameController.text.trim();

//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegex.hasMatch(email) || !email.endsWith('@gmail.com')) {
//       showMessage("Enter a valid Gmail address");
//       return;
//     }

//     if (!isPasswordStrong(password)) {
//       showMessage(
//         "Password must be at least 8 characters long, and contain at least one uppercase letter, one lowercase letter, one digit, and one special character.",
//       );
//       return;
//     }

//     if (email.isEmpty ||
//         password.isEmpty ||
//         confirmPassword.isEmpty ||
//         firstName.isEmpty ||
//         lastName.isEmpty) {
//       showMessage("Please fill in all fields");
//       return;
//     }

//     if (!isChecked) {
//       showMessage("You must agree to the terms and policy");
//       return;
//     }

//     if (password != confirmPassword) {
//       showMessage("Passwords do not match");
//       return;
//     }

//     var box = Hive.box('usersBox');
//     if (box.containsKey(email)) {
//       showMessage("User already exists");
//       return;
//     }

//     // ✅ FIXED: Save user data as a Map instead of just password
//     box.put(email, {
//       'firstName': firstName,
//       'lastName': lastName,
//       'password': password,
//     });

//     showMessage("User registered successfully");
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF011B30),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 60),
//             const Text(
//               'Sign Up',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 35,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 30),
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: TextField(
//                       controller: _firstNameController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.black26,
//                         labelText: 'First Name',
//                         hintText: 'Enter First Name',
//                         labelStyle: const TextStyle(color: Colors.white),
//                         hintStyle: const TextStyle(color: Colors.white54),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Colors.blueAccent,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Colors.lightBlue,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: TextField(
//                       controller: _lastNameController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.black26,
//                         labelText: 'Last Name',
//                         hintText: 'Enter Last Name',
//                         labelStyle: const TextStyle(color: Colors.white),
//                         hintStyle: const TextStyle(color: Colors.white54),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Colors.blueAccent,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Colors.lightBlue,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             TextField(
//               controller: _emailController,
//               style: const TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.black26,
//                 labelText: 'Email',
//                 hintText: 'Enter your Email',
//                 labelStyle: const TextStyle(color: Colors.white),
//                 hintStyle: const TextStyle(color: Colors.white54),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     color: Colors.blueAccent,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     color: Colors.lightBlue,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               style: const TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.black26,
//                 labelText: 'Password',
//                 hintText: 'Use Lower,Digit & Special Char(8+ chars)',
//                 labelStyle: const TextStyle(color: Colors.white),
//                 hintStyle: const TextStyle(color: Colors.white54),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     color: Colors.blueAccent,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     color: Colors.lightBlue,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _confirmPasswordController,
//               obscureText: true,
//               style: const TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: Colors.black26,
//                 labelText: 'Confirm password',
//                 hintText: 'Re-enter your Password',
//                 labelStyle: const TextStyle(color: Colors.white),
//                 hintStyle: const TextStyle(color: Colors.white54),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     color: Colors.blueAccent,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     color: Colors.lightBlue,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isChecked = !isChecked;
//                     });
//                   },
//                   child: Container(
//                     width: 24,
//                     height: 24,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: isChecked ? Colors.green : Colors.white,
//                         width: 2,
//                       ),
//                       color: isChecked ? Colors.green : Colors.transparent,
//                     ),
//                     child:
//                         isChecked
//                             ? const Icon(
//                               Icons.check,
//                               size: 18,
//                               color: Colors.white,
//                             )
//                             : null,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 const Text(
//                   'Agree with our terms and policy',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: registerUser,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF0C13FF),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Sign Up',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Already have an account?',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/login');
//                   },
//                   child: const Text(
//                     'Sign In',
//                     style: TextStyle(
//                       color: Colors.blueAccent,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// // }import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'login_page.dart';
// import 'package:flutter/material.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   static const routename = '/signup';
//   bool isChecked = false;

//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool isPasswordStrong(String password) {
//     RegExp pattern = RegExp(
//       r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
//     );
//     return pattern.hasMatch(password);
//   }

//   void showMessage(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   void registerUser() {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text;
//     String confirmPassword = _confirmPasswordController.text;

//     if (_firstNameController.text.isEmpty ||
//         _lastNameController.text.isEmpty ||
//         email.isEmpty ||
//         password.isEmpty ||
//         confirmPassword.isEmpty) {
//       showMessage("Please fill in all fields");
//       return;
//     }

//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegex.hasMatch(email) || !email.endsWith('@gmail.com')) {
//       showMessage("Enter a valid Gmail address");
//       return;
//     }

//     if (!isPasswordStrong(password)) {
//       showMessage("Weak password. Use upper, lower, digit & special char.");
//       return;
//     }

//     if (password != confirmPassword) {
//       showMessage("Passwords do not match");
//       return;
//     }

//     if (!isChecked) {
//       showMessage("You must agree to the terms");
//       return;
//     }

//     final box = Hive.box('usersBox');
//     if (box.containsKey(email)) {
//       showMessage("User already exists");
//       return;
//     }

//     // ✅ Store as a map
//     box.put(email, {'password': password});

//     showMessage("Registration successful");
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF011B30),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 60),
//             const Text(
//               'Sign Up',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 35,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 30),
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: TextField(
//                       controller: _firstNameController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: _fieldDecoration(
//                         'First Name',
//                         'Enter First Name',
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: TextField(
//                       controller: _lastNameController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: _fieldDecoration(
//                         'Last Name',
//                         'Enter Last Name',
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             TextField(
//               controller: _emailController,
//               style: const TextStyle(color: Colors.white),
//               decoration: _fieldDecoration('Email', 'Enter your Email'),
//             ),
//             const SizedBox(height: 30),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               style: const TextStyle(color: Colors.white),
//               decoration: _fieldDecoration(
//                 'Password',
//                 'Use Lower,Digit & Special Char(8+ chars)',
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _confirmPasswordController,
//               obscureText: true,
//               style: const TextStyle(color: Colors.white),
//               decoration: _fieldDecoration(
//                 'Confirm password',
//                 'Re-enter your Password',
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () => setState(() => isChecked = !isChecked),
//                   child: Container(
//                     width: 24,
//                     height: 24,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: isChecked ? Colors.green : Colors.white,
//                         width: 2,
//                       ),
//                       color: isChecked ? Colors.green : Colors.transparent,
//                     ),
//                     child:
//                         isChecked
//                             ? const Icon(
//                               Icons.check,
//                               size: 18,
//                               color: Colors.white,
//                             )
//                             : null,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 const Text(
//                   'Agree with our terms and policy',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: registerUser,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF0C13FF),
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Sign Up',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Already have an account?',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.pushNamed(context, '/login'),
//                   child: const Text(
//                     'Sign In',
//                     style: TextStyle(
//                       color: Colors.blueAccent,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   InputDecoration _fieldDecoration(String label, String hint) {
//     return InputDecoration(
//       filled: true,
//       fillColor: Colors.black26,
//       labelText: label,
//       hintText: hint,
//       labelStyle: const TextStyle(color: Colors.white),
//       hintStyle: const TextStyle(color: Colors.white54),
//       enabledBorder: OutlineInputBorder(
//         borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
// }
