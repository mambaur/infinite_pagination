class User {
  String? id, name, avatar, email;

  User({this.id, this.name, this.avatar, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        avatar: json['avatar'],
        email: json['email']);
  }
}
