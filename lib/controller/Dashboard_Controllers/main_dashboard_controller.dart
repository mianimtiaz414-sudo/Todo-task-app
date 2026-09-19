import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_app/Routs/routs_over_all.dart';
import 'package:getx_mvvm_app/controller/Dashboard_Controllers/local_storage_service_controller.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  final LocalStorageService _storage = LocalStorageService();

  var tasks = <String>[].obs;
  var currentFilter = "All".obs;

  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();
  final newCategoryController = TextEditingController();

  var selectedDate = DateTime.now().obs;
  var calendarDates = <DateTime>[].obs;
  var userCategories = <String>[].obs;
  var selectedCategory = "".obs;

  @override
  void onInit() {
    super.onInit();
    generateCalendarDates();
    loadTasks();
    loadCategories();
  }

  void generateCalendarDates() {
    DateTime baseDate = selectedDate.value;
    List<DateTime> dates = [];
    for (int i = -15; i <= 15; i++) {
      dates.add(baseDate.add(Duration(days: i)));
    }
    calendarDates.assignAll(dates);
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    generateCalendarDates();
    loadTasks();
  }

  void pickCalendarDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFF63D5F),
              onPrimary: Colors.white,
              onSurface: Color(0xFF1E1E24),
            ),
          ),
          child: SingleChildScrollView(child: child!),
        );
      },
    );
    if (picked != null) {
      selectDate(picked);
    }
  }

  String get selectedMonthYear {
    return DateFormat('MMMM yyyy').format(selectedDate.value);
  }

  void loadTasks() {
    String dateKey = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    tasks.assignAll(_storage.getTasksForDate(dateKey));
  }

  void loadCategories() {
    userCategories.assignAll(_storage.getCategories());
  }

  void openCreateCategoryDialog() {
    Get.defaultDialog(
      title: "Create Category",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          controller: newCategoryController,
          decoration: const InputDecoration(hintText: "Category name..."),
        ),
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF63D5F),
        ),
        onPressed: () {
          String catName = newCategoryController.text.trim();
          if (catName.isNotEmpty) {
            userCategories.add(catName);
            _storage.saveCategories(userCategories.toList());
            userCategories.refresh();
            newCategoryController.clear();
            Get.back();
          }
        },
        child: const Text("Save", style: TextStyle(color: Colors.white)),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: const Text("Cancel"),
      ),
    );
  }

  void deleteCategory(String catName) {
    Get.defaultDialog(
      title: "Delete Category",
      content: Text("Are you sure you want to delete '$catName'?"),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
        onPressed: () {
          userCategories.remove(catName);
          _storage.saveCategories(userCategories.toList());
          if (selectedCategory.value == catName) {
            selectedCategory.value = "";
          }
          userCategories.refresh();
          Get.back();
        },
        child: const Text("Delete", style: TextStyle(color: Colors.white)),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: const Text("Cancel"),
      ),
    );
  }

  void addTask(String title, String desc) {
    String finalTaskText = title;
    if (selectedCategory.value.isNotEmpty) {
      finalTaskText = "[$selectedCategory.value] $finalTaskText";
    }
    if (desc.isNotEmpty) {
      finalTaskText = "$finalTaskText - $desc";
    }

    tasks.add(finalTaskText);
    String dateKey = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    _storage.saveTasksForDate(dateKey, tasks.toList());
    selectedCategory.value = "";
    tasks.refresh();
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    String dateKey = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    _storage.saveTasksForDate(dateKey, tasks.toList());
    tasks.refresh();
  }

  void logoutUser() async {
    await _storage.clearUserSession();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    taskTitleController.dispose();
    taskDescController.dispose();
    newCategoryController.dispose();
    super.onClose();
  }
}
