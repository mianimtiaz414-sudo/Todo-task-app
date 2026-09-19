import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_app/controller/intro_pages_controller.dart';

class intro_screen1 extends GetView<OnboardingScreen2Controller> {
  const intro_screen1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Obx(() {
            final currentData =
                controller.pagesData[controller.currentpage.value];

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Header (Page Number & Skip)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentData["pageNumber"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (controller.currentpage.value < 2)
                      TextButton(
                        onPressed: () => controller.skipToLast(),
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 48),
                  ],
                ),

                // Center Swipable Image Section
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: controller.pagesData.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Image.asset(
                          controller.pagesData[index]["image"]!,
                          width: screenSize.width * 0.85,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              index == 0
                                  ? Icons.shopping_bag_outlined
                                  : index == 1
                                  ? Icons.credit_card_rounded
                                  : Icons.local_shipping_outlined,
                              size: 150,
                              color: const Color(0xFFF63D5F),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Content Section (Title, Subtitle, Dots, Buttons)
                Column(
                  children: [
                    Text(
                      currentData["title"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentData["subtitle"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dots Indicator
                        Row(
                          children: List.generate(3, (index) {
                            bool isActive =
                                controller.currentpage.value == index;
                            return Container(
                              margin: const EdgeInsets.only(right: 6),
                              width: isActive ? 24 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? const Color(0xFF1A1F36)
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            );
                          }),
                        ),
                        // Next/Finish Button
                        TextButton(
                          onPressed: () => controller.movednext(),
                          child: Text(
                            controller.currentpage.value == 2
                                ? "Get Started"
                                : "Next",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF63D5F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
