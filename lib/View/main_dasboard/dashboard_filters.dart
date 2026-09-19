import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_app/controller/Dashboard_Controllers/main_dashboard_controller.dart';

Widget buildFilterChipsRow(DashboardController controller) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        _buildFilterChip("All", controller),
        _buildFilterChip("To do", controller),
        _buildFilterChip("In Progress", controller),
        _buildFilterChip("Completed", controller),
      ],
    ),
  );
}

Widget _buildFilterChip(String label, DashboardController controller) {
  return Obx(() {
    bool isActive = controller.currentFilter.value == label;
    return GestureDetector(
      onTap: () => controller.currentFilter.value = label,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF63D5F) : const Color(0xFFF0EBF5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF9E8EAD),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  });
}
