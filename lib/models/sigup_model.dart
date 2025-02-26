class SigUpBody {
  String name;
  String email;
  String password;
  String area_code;
  String number;

  SigUpBody({
    required this.name,
    required this.email,
    required this.password,
    required this.area_code,
    required this.number
  });

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["email"] = email;
    data["passord"] = password;
    data["area_code"] = area_code;
    data["number"] = number;
    return data;
  }
} 