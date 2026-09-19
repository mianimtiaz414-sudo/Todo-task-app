import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Routs/routs_over_all.dart';

class OnboardingScreen2Controller extends GetxController {
  var currentpage = 0.obs;
  final PageController pageController = PageController(initialPage: 0);

  final List<Map<String, String>> pagesData = [
    {
      "title": "Choose Products",
      "subtitle":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
      "pageNumber": "1/3",
      "image": "assets/images/fashion shop-rafiki 1.png",
    },
    {
      "title": "Make Payment",
      "subtitle":
          "Easy and secure payment options to make your shopping experience hassle-free and convenient.",
      "pageNumber": "2/3",
      "image": "assets/images/Sales consulting-pana 1.png",
    },
    {
      "title": "Get Your Order",
      "subtitle":
          "Fast and efficient delivery system that ensures your product reaches your doorstep on time.",
      "pageNumber": "3/3",
      "image": "assets/images/Shopping bag-rafiki 1.png",
    },
  ];

  void onPageChanged(int index) {
    currentpage.value = index;
  }

  void movednext() {
    if (currentpage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void skipToLast() {
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
