import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('https://bid4stylepgre.visionvivante.in/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        print("✅ Valid credentials: ${response.body}");
        return jsonDecode(response.body); // return decoded JSON
      } else {
        print("❌ Invalid credentials: ${response.body}");
        final decoded = jsonDecode(response.body);
        return {
          "status": false,
          "message":
              decoded["message"] ?? decoded["error"] ?? "Invalid credentials",
        };
      }
    } catch (e) {
      print("⚠️ Error: $e");
      return {
        "success": false,
        "message": "Something went wrong",
        "error": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> register(name, email, phone, password) async {
    final url = Uri.parse('https://bid4stylepgre.visionvivante.in/auth/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Valid credentials: ${response.body}");
        return jsonDecode(response.body); // return decoded JSON
      } else {
        print("❌ Invalid credentials: ${response.body}");
        final decoded = jsonDecode(response.body);
        return {
          "status": false,
          "message":
              decoded["message"] ?? decoded["error"] ?? "Invalid credentials",
        };
      }
    } catch (e) {
      print("⚠️ Error: $e");
      return {
        "success": false,
        "message": "Something went wrong",
        "error": e.toString(),
      };
    }
  }
}
