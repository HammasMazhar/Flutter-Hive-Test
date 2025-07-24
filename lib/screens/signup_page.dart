import 'package:flutter/material.dart';
import 'package:flutter_hive_test/screens/constants.dart';
import 'package:hive/hive.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;
  bool isSignupLoginTapped = false;
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  String? firstnameValidation(String? value) {
    final firstName = _firstNameController.text.trim();
    if (value == null || value.isEmpty) {
      return ' Enter first Name';
    } else if (firstName.length < 2) {
      return 'At least 2 characters long';
    }
    return null;
  }

  String? lastnameValidation(String? value) {
    final firstName = _lastNameController.text.trim();
    if (value == null || value.isEmpty) {
      return ' Enter Last Name';
    } else if (firstName.length < 2) {
      return 'At least 2 characters long';
    }
    return null;
  }

  String? emailValidation(String? value) {
    final email = _emailController.text.trim();
    Hive.box('usersBox');
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null || value.isEmpty) {
      return 'Enter Email';
    } else if (!emailRegex.hasMatch(email) || !email.endsWith('@gmail.com')) {
      return 'Enter a Valid Gmail Address';
    }
    return null;
  }

  String? passwordvalidation(String? value) {
    final password = _passwordController.text.trim();
    if (value == null || value.isEmpty) {
      return 'Enter Password';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    ).hasMatch(password)) {
      return 'Password must contain at least one uppercase ,one lowercase letter,one digit,one special character.';
    }
    return null;
  }

  String? confirmPasswordValidation(String? value) {
    final confirmPassword = _confirmPasswordController.text.trim();
    if (value == null || value.isEmpty) {
      return 'Re-enter Password';
    } else if (confirmPassword != _passwordController.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> registerUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (!isChecked) {
      showMessage("You must agree to the terms and policy");
      return;
    }
    var box = Hive.box('usersBox');
    if (box.containsKey(email)) {
      showMessage("User already exists");
      return;
    }
    await box.put(email, password);
    showMessage("User registered successfully");
    Navigator.pushNamed(context, ('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B30),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Sign Up', style: kHeadingSignUpTextStyle),
              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextFormField(
                        validator: firstnameValidation,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _firstNameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black26,
                          labelText: 'First Name',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Enter First Name',
                          labelStyle: const TextStyle(color: Colors.white),
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
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
                      child: TextFormField(
                        controller: _lastNameController,
                        validator: lastnameValidation,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black26,
                          labelText: 'Last Name',
                          hintText: 'Enter Last Name',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: const TextStyle(color: Colors.white),
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
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

              TextFormField(
                controller: _emailController,
                validator: emailValidation,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  labelText: 'Email',
                  hintText: 'Enter your Email',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              TextFormField(
                controller: _passwordController,
                validator: passwordvalidation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: obscurePassword1,

                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  labelText: 'Password',
                  hintText: 'Enter your Password',
                  errorMaxLines: 2,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword1
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        // Toggle password visibility
                        obscurePassword1 = !obscurePassword1;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _confirmPasswordController,
                validator: confirmPasswordValidation,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: obscurePassword2,

                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  labelText: 'Confirm password',
                  hintText: 'Re-enter your Password',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword2
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword2 = !obscurePassword2;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isChecked ? Colors.white : Colors.white,
                          width: 2,
                        ),
                        color: isChecked ? Colors.green : Colors.transparent,
                      ),
                      child:
                          isChecked
                              ? const Icon(
                                Icons.check,
                                size: 10,
                                color: Colors.white,
                              )
                              : null,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: const Text(
                      'Agree with our terms and policy',
                      style: kAgreePolicy,
                    ),
                  ),
                ],
              ),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(right: 80, left: 80),
                  child: ElevatedButton(
                    onPressed:
                        isSignupLoginTapped
                            ? null
                            : () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isSignupLoginTapped = true;
                                });
                                await registerUser();
                                await Future.delayed(
                                  const Duration(seconds: 3),
                                );
                                setState(() {
                                  isSignupLoginTapped = false;
                                });
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C13FF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: SizedBox(
                      height: 30,
                      child: Center(
                        child:
                            isSignupLoginTapped
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),

                                    strokeWidth: 3,
                                  ),
                                )
                                : const Text(
                                  'Sign Up',
                                  style: kSignUpTextButton,
                                ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: kAlreadyAccountTextStyle,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Sign Up',
                      style: kAlreadyAccountSignUpTextButton,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Signup Requirements:',
                style: kRequirementHeadingTextStyle,
              ),
              const SizedBox(height: 8),
              const Text(
                '• Full Name must include at least **two words** (e.g., John Doe)\n'
                '• Email must be valid and end with "@gmail.com"\n'
                '• Password must be at least 8 characters and include:\n'
                '     - At least one uppercase letter\n'
                '     - At least one lowercase letter\n'
                '     - At least one digit\n'
                '     - At least one special character (!@#\$&*~)\n'
                '• Confirm Password must match the Password\n'
                '• You must agree to the Terms and Privacy Policy checkbox',
                style: kRequirementsTextStyle,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
