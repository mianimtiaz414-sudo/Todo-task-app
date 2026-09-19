import 'package:flutter/material.dart';
import 'package:getx_mvvm_app/controller/Dashboard_Controllers/main_dashboard_controller.dart';

Widget buildHeaderView(DashboardController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 22,
          ),
          onPressed: () => controller.logoutUser(),
        ),
        const Text(
          "Today’s Tasks",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1E1E24),
            letterSpacing: -0.5,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Colors.black87,
            size: 26,
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}
