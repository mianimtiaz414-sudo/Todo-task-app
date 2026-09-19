import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final Box _box = Hive.box('userBox');

  List<String> getTasksForDate(String dateKey) {
    List? saved = _box.get('tasks_$dateKey');
    return saved != null ? saved.cast<String>() : [];
  }

  void saveTasksForDate(String dateKey, List<String> tasksList) {
    _box.put('tasks_$dateKey', tasksList);
  }

  List<String> getCategories() {
    List? saved = _box.get('user_categories');
    return saved != null ? saved.cast<String>() : [];
  }

  void saveCategories(List<String> categoriesList) {
    _box.put('user_categories', categoriesList);
  }

  Future<void> clearUserSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
  }
}
