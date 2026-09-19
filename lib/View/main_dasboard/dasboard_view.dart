import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_app/Routs/routs_over_all.dart';
import 'package:getx_mvvm_app/View/main_dasboard/add_task_bottom_sheet_view.dart';
import 'package:getx_mvvm_app/View/main_dasboard/category_selection_sheet.dart';
import 'package:getx_mvvm_app/View/main_dasboard/dashboard_calendar.dart';
import 'package:getx_mvvm_app/View/main_dasboard/dashboard_filters.dart';
import 'package:getx_mvvm_app/View/main_dasboard/dashboard_header.dart';
import 'package:getx_mvvm_app/controller/Dashboard_Controllers/main_dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FC),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeaderView(controller),
            const SizedBox(height: 10),
            buildCalendarHorizontalList(controller),
            const SizedBox(height: 24),
            buildFilterChipsRow(controller),
            Expanded(child: _buildTasksListView()),
            _buildBottomNavigationBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTasksListView() {
    return Obx(() {
      if (controller.tasks.isEmpty) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_off_outlined,
                  size: 140,
                  color: Colors.grey.withAlpha(100),
                ),
                const SizedBox(height: 20),
                const Text(
                  "No Todo Found!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Please Create One",
                  style: TextStyle(fontSize: 14, color: Colors.black38),
                ),
              ],
            ),
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: controller.tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(controller.tasks[index] + index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              color: Colors.redAccent,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) => controller.deleteTask(index),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFFF63D5F),
                ),
                title: Text(
                  controller.tasks[index],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_mini_outlined, "Index", true),
          GestureDetector(
            onTap: () => controller.pickCalendarDate(),
            child: _buildNavItem(
              Icons.calendar_month_outlined,
              "Calendar",
              false,
            ),
          ),
          GestureDetector(
            onTap: () => showModalAddTaskSheet(context, controller),
            child: Transform.translate(
              offset: const Offset(0, -15),
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFF63D5F),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 28),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => showCategorySelectionSheet(context, controller),
            child: _buildNavItem(Icons.access_time, "Focus", false),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.profile),
            child: _buildNavItem(Icons.person_outline, "Profile", false),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF1E1E24) : Colors.black38,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isActive ? const Color(0xFF1E1E24) : Colors.black38,
          ),
        ),
      ],
    );
  }
}
