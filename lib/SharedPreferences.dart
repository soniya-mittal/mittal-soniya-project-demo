import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferencesHelper {
  void saveData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getData(String key) async {
    String? data;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data = await prefs.getString(key);
    return data;
  }

  Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
