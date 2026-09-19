import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_app/View/main_dasboard/category_selection_sheet.dart';
import 'package:getx_mvvm_app/controller/Dashboard_Controllers/main_dashboard_controller.dart';

void showModalAddTaskSheet(
  BuildContext context,
  DashboardController controller,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 24.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add Task",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.taskTitleController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.taskDescController,
              decoration: InputDecoration(
                hintText: "Description",
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.watch_later_outlined,
                        color: Colors.black87,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.local_offer_outlined,
                        color: Colors.black87,
                        size: 24,
                      ),
                      onPressed: () =>
                          showCategorySelectionSheet(context, controller),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.outlined_flag_rounded,
                        color: Colors.black87,
                        size: 24,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send_sharp,
                    color: Color(0xFFF63D5F),
                    size: 26,
                  ),
                  onPressed: () {
                    String title = controller.taskTitleController.text.trim();
                    String desc = controller.taskDescController.text.trim();
                    if (title.isNotEmpty) {
                      controller.addTask(title, desc);
                      controller.taskTitleController.clear();
                      controller.taskDescController.clear();
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
