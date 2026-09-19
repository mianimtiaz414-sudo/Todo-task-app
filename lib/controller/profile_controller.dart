import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm_app/Routs/routs_over_all.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final Box _box = Hive.box('userBox');
  final ImagePicker _picker = ImagePicker();

  var userName = "Martha Hays".obs;
  var profileImagePath = "".obs;
  var taskLeftCount = 0.obs;
  var taskDoneCount = 0.obs;

  final nameEditController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    calculateLiveStats();
  }

  void loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currentEmail = prefs.getString('currentUserEmail') ?? 'default';

    userName.value = _box.get('${currentEmail}_name') ?? "Martha Hays";
    profileImagePath.value = _box.get('${currentEmail}_profile_pic') ?? "";
  }

  void calculateLiveStats() {
    int totalLeft = 0;
    int totalDone = 0;

    final keys = _box.keys.where((key) => key.toString().startsWith('tasks_'));
    for (var key in keys) {
      List? savedTasks = _box.get(key);
      if (savedTasks != null) {
        totalLeft += savedTasks.length;
      }
    }

    taskLeftCount.value = totalLeft;
    taskDoneCount.value = totalDone;
  }

  void pickNewProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? currentEmail = prefs.getString('currentUserEmail') ?? 'default';

      profileImagePath.value = image.path;
      await _box.put('${currentEmail}_profile_pic', image.path);
    }
  }

  void showChangeNameDialog() {
    nameEditController.text = userName.value;
    Get.defaultDialog(
      title: "Change Name",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          controller: nameEditController,
          decoration: const InputDecoration(hintText: "Enter new name..."),
        ),
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF63D5F),
        ),
        onPressed: () async {
          String newName = nameEditController.text.trim();
          if (newName.isNotEmpty) {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            String? currentEmail =
                prefs.getString('currentUserEmail') ?? 'default';

            userName.value = newName;
            await _box.put('${currentEmail}_name', newName);
            Get.back();
          }
        },
        child: const Text("Update", style: TextStyle(color: Colors.white)),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: const Text("Cancel"),
      ),
    );
  }

  void logoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('currentUserEmail');
    Get.offAllNamed(AppRoutes.onboarding);
  }

  @override
  void onClose() {
    nameEditController.dispose();
    super.onClose();
  }
}
