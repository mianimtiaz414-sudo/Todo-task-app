import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Routs/routs_over_all.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  final Box _userBox = Hive.box('userBox');

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    String? savedPassword = _userBox.get('${email}_password');

    if (savedPassword != null && savedPassword == password) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('currentUserEmail', email);

      emailController.clear();
      passwordController.clear();

      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.snackbar(
        "Auth Failed",
        "Invalid email or password",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    await _userBox.put('${email}_name', name);
    await _userBox.put('${email}_password', password);

    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('currentUserEmail', email);

    Get.snackbar(
      "Success",
      "Account created successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.offAllNamed(AppRoutes.dashboard);
  }

  void logoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('currentUserEmail');
    Get.offAllNamed(AppRoutes.onboarding);
  }
}
