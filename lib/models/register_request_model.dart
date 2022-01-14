class RegisterRequestModel {
  RegisterRequestModel({
    required this.userName,
    required this.password,
    required this.email,
    required this.mobile,
  });
  late final String userName;
  late final String password;
  late final String email;
  late final String mobile;

  RegisterRequestModel.fromJson(Map<String, dynamic> json){
    userName = json['userName'];
    password = json['password'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userName'] = userName;
    _data['password'] = password;
    _data['email'] = email;
    _data['mobile'] = mobile;
    return _data;
  }
}