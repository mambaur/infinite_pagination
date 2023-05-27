import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infinite_pagination/models/user.dart';

class UserRepository {
  final String _baseUrl = "https://60fec25a2574110017078789.mockapi.io";
  Future<List<User>> getUser(int page, int limit) async {
    final response = await http
        .get(Uri.parse("$_baseUrl/api/v1/users?page=$page&limit=$limit"));
    final data = json.decode(response.body);
    return List<User>.from(data.map((e) => User.fromJson(e)));
  }
}
