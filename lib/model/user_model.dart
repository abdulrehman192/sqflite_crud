class User {
  int? id;
  String? username;
  String? email;
  String? password;

  User({int? id, required String username,required String email,required String password})
  {
    this.id = id;
    this.username = username;
    this.email = email;
    this.password = password;
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
