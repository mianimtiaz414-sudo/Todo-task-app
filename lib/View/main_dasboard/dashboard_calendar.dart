import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_app/controller/Dashboard_Controllers/main_dashboard_controller.dart';
import 'package:intl/intl.dart';

Widget buildCalendarHorizontalList(DashboardController controller) {
  return SizedBox(
    height: 90,
    child: Obx(
      () => ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: controller.calendarDates.length,
        itemBuilder: (context, index) {
          DateTime date = controller.calendarDates[index];
          bool isActive =
              DateFormat('yyyy-MM-dd').format(controller.selectedDate.value) ==
              DateFormat('yyyy-MM-dd').format(date);

          return GestureDetector(
            onTap: () => controller.selectDate(date),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFF63D5F) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (isActive)
                    BoxShadow(
                      color: const Color(0xFFF63D5F).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      fontSize: 11,
                      color: isActive ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      fontSize: 11,
                      color: isActive ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
