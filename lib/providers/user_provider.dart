import 'package:flutter/foundation.dart';
import 'package:infinite_pagination/models/user.dart';
import 'package:infinite_pagination/repositories/user_repositories.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  final int _limit = 15;
  int _page = 1;
  bool hasMore = true;
  List<User> users = [];

  Future fetchUser() async {
    try {
      List<User> response = await _userRepository.getUser(_page, _limit);

      if (response.length < _limit) {
        hasMore = false;
      }

      users.addAll(response);

      _page++;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refresh() async {
    _page = 1;
    users = [];
    hasMore = true;
    await fetchUser();
    notifyListeners();
  }
}
