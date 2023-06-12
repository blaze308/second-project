import "dart:convert";
import "package:http/http.dart" as http;

class NodeConnect {
  static Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:5000/data"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception("failed to fetch data");
    }
  }

  static Future<void> signUp(
      String username, String email, String password) async {
    const url = "http://10.0.2.2:5000/api/signup";
    final body = {"username": username, "email": email, "password": password};

    final checkResponse = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));

    if (checkResponse.statusCode == 200 &&
        checkResponse.body.contains("user exists")) {
      print("${jsonDecode(checkResponse.body)["message"]}");
      return;
    }

    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));

    if (response.statusCode == 201) {
      print("User created successfully");
    } else {
      print("Failed to create user");
    }
  }

  //login
  static Future<void> login(String identifier, String password) async {
    final body = jsonEncode({
      "identifier": identifier,
      "password": password,
    });

    final headers = {"Content-Type": "application/json"};

    final response = await http.post(
        Uri.parse("http://10.0.2.2:5000/api/login"),
        headers: headers,
        body: body);

    //handle response
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Login successful: ${data['message']}");
    } else {
      print("Login failed: ${data['error']}");
    }
  }
}
